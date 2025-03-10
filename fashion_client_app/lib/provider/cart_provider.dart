import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/cart_model.dart';
import 'package:fashion_client_app/model/products_model.dart';
import 'package:fashion_client_app/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _cartSubscription;
  StreamSubscription<QuerySnapshot>? _productSubscription;
  bool isLoading = false;
  List<CartModel> cart = [];
  List<String> cartUids = [];
  List<ProductModels> product = [];
  int totalCost = 0;
  int totalQuantity = 0;

  CartProvider() {
   // In provider constructor:
FirebaseAuth.instance.authStateChanges().listen((User? user) {
  if (user != null) {
    // User is signed in, load data
  readCartData();
  } else {
    // User is signed out, clear data
    cancelProvider();
  }
});
  }
void reloadData() {
  if (FirebaseAuth.instance.currentUser != null) {
   readCartData();
  }
}
  Future<void> addToCart(CartModel cartData) async {
    await DbService().addToCart(cartData: cartData);
    notifyListeners();
  }

  void readCartData() {
    isLoading = true;
    notifyListeners();
    print("Fetching cart data...");
    _cartSubscription?.cancel();
    _cartSubscription = DbService().readCart().listen((snapshot) {
      print("Cart snapshot received: ${snapshot.docs.length} items");
      List<CartModel> cartsData = snapshot.docs.map((doc) {
        print("Cart Item Data: ${doc.data()}");
        return CartModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      cart = cartsData;
      cartUids = cart.map((item) => item.productId).toList();
      if (cart.isNotEmpty) {
        print("Calling readCartProducts with UIDs: $cartUids");
        readCartProducts(cartUids);
      } else {
        product.clear();
        totalCost = 0;
        totalQuantity = 0;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void deleteItem(String cartId) async {
    await DbService().deleteItemFromCart(cartId: cartId);
    readCartData();
    notifyListeners();
  }

  void increaseQuantity(String cartId) {
    addToCart(CartModel(
      cartId: cartId,
      productId: cartId,
      size: "",
      color: "",
      quantity: 1,
    ));
    notifyListeners();
  }

  void decreaseCount(String cartId) {
    DbService().decreaseCount(cartId: cartId);
    notifyListeners();
  }

  void readCartProducts(List<String> uids) {
    print("Fetching product details for UIDs: $uids");
    _productSubscription?.cancel();
    _productSubscription = DbService().searchProducts(uids).listen((snapshot) {
      print("Product snapshot received: ${snapshot.docs.length} products");
      Map<String, ProductModels> productMap = {};

      for (var doc in snapshot.docs) {
        var product =
            ProductModels.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        productMap[product.id] = product;
      }

      product = cart.map((cartItem) {
        return productMap[cartItem.productId] ??
            ProductModels(
              name: "Unknown Product",
              description: "No description available",
              images: [],
              oldPrice: 0,
              newPrice: 0,
              category: "Unknown",
              id: cartItem.productId,
              maxQuantity: 0,
              colorVariants: [],
              sizeVariants: [],
            );
      }).toList();

      print("Cart Products: ${product.length} items fetched");
      addCost(product, cart);
      calculateTotalQuantity();
      isLoading = false;
      notifyListeners();
    });
  }

  void addCost(List<ProductModels> products, List<CartModel> cart) {
    totalCost = 0;
    for (int i = 0; i < cart.length; i++) {
      if (i < products.length) {
        totalCost += cart[i].quantity * products[i].newPrice;
      } else {
        print("Index out of bounds: $i");
      }
    }
    notifyListeners();
  }

  void calculateTotalQuantity() {
    totalQuantity = cart.fold(0, (sum, item) => sum + item.quantity);
    print("totalQuantity: $totalQuantity");
    notifyListeners();
  }

  Future<void> buyProduct(
      {required BuildContext context,
      required String selectedSize,
      required String selectedColor,
      required String productId,
      bool isCart = true}) async {
    if (selectedSize.isEmpty || selectedColor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomSnackBar(
            errorMessage: "Please select both size and color",
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    } else {
      String cartId = "${productId}_${selectedSize}_${selectedColor}";
      await addToCart(
        CartModel(
          productId: productId,
          quantity: 1,
          size: selectedSize,
          color: selectedColor,
          cartId: cartId,
        ),
      );
      if (isCart) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Added to cart"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void resetState() {
    cart.clear();
    cartUids = [];
    cart = [];
    product = [];
    product.clear();
    totalCost = 0;
    totalQuantity = 0;
    isLoading = false;
    notifyListeners();
  }

  void cancelProvider() {
    _cartSubscription?.cancel();
    _productSubscription?.cancel();
    resetState();
    notifyListeners();
  }

  @override
  void dispose() {
    cancelProvider();
    super.dispose();
  }
}
