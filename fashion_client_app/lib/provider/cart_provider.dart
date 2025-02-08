import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/cart_model.dart';
import 'package:fashion_client_app/model/products_model.dart';
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
    readCartData();
  }
  void addToCart(CartModel cartData) {
    DbService().addToCart(cartData: cartData);
    notifyListeners();
  }

//stream and read cart data
  void readCartData() {
    isLoading = true;
    print("------------------");
    print("Fetching cart data...");
    _cartSubscription?.cancel();
    _cartSubscription = DbService().readCart().listen((snapshot) {
      print("Cart snapshot received: ${snapshot.docs.length} items");
      List<CartModel> cartsData = snapshot.docs.map((doc) {
         print("Cart Item Data: ${doc.data()}");
        return CartModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      cart = cartsData;
      cartUids = [];
      for (int i = 0; i < cart.length; i++) {
        cartUids.add(cart[i].productId);
    print("Cart Product ID [${i}]: ${cartUids[i]}");  
      }
      if (cart.isNotEmpty) {
          print("Calling readCartProducts with UIDs: $cartUids"); 
        readCartProducts(cartUids);
      }
      isLoading = false;
      notifyListeners();
    });
  }

  void deleteItem(String cartId) {
    DbService().deleteItemFromCart(cartId: cartId);
    readCartData();
    notifyListeners();
  }

  void increaseQuantity(String cartId) {
    addToCart(CartModel(
      cartId: cartId,
      productId: cartId,
      size: "", // These will be preserved
      color: "", // These will be preserved
      quantity: 1,
    ));
    notifyListeners();
  }

//decrease the count of product
  void decreaseCount(String cartId) {
    DbService().decreaseCount(cartId: cartId);

    notifyListeners();
  }

  //read cart products
  // void readCartProducts(List<String> uids) {
  //    print("Fetching product details for UIDs: $uids");  
  //   _productSubscription?.cancel();
  //   _productSubscription = DbService().searchProducts(uids).listen((snapshot) {
  //         print("Product snapshot received: ${snapshot.docs.length} products");
  //     List<ProductModels> productData =
  //         ProductModels.fromJsonList(snapshot.docs) as List<ProductModels>;
  //     product = productData;
  //     isLoading = false;
  //     addCost(product, cart);
  //     calculateTotalQuantity();
  //     notifyListeners();
  //   });
  // }
void readCartProducts(List<String> uids) {
  print("Fetching product details for UIDs: $uids");

  _productSubscription?.cancel();
  _productSubscription = DbService().searchProducts(uids).listen((snapshot) {
    print("Product snapshot received: ${snapshot.docs.length} products");

    Map<String, ProductModels> productMap = {}; // Use a map to store products

    for (var doc in snapshot.docs) {
      var product = ProductModels.fromJson(doc.data() as Map<String, dynamic>, doc.id); // Fix: Pass doc.id

      print("Product Data: ${doc.data()}");

      productMap[product.id] = product;
    }

    product = cart.map((cartItem) {
      return productMap.containsKey(cartItem.productId) 
          ? productMap[cartItem.productId]! 
          : ProductModels(
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

    notifyListeners();
  });
}


  
  void addCost(List<ProductModels> products, List<CartModel> cart) {
    totalCost = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < cart.length; i++) {
        if (i < products.length) {
          // Ensure the index is within the valid range
          totalCost += cart[i].quantity * products[i].newPrice;
        } else {
          print("Index out of bounds: $i");
        }
      }
      notifyListeners();
    });
  }

  void calculateTotalQuantity() {
    totalQuantity = 0;
    for (int i = 0; i < cart.length; i++) {
      totalQuantity += cart[i].quantity;
    }
    print("totalQuantity: $totalQuantity");
    notifyListeners();
  }
}
