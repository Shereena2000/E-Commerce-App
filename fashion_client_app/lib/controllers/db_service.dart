import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  User? user = FirebaseAuth.instance.currentUser;

//ad the user to firebase

  Future saveUserData({required String name, required String email}) async {
    try {
      Map<String, dynamic> data = {"name": name, "email": email};
      print("saving $data");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .set(data);
    } catch (e) {
      print("error on saving user data:$e");
    }
  }

//update otherdata in database
  Future updateUserData({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update(data);
  }

//read user current user data
  Stream<DocumentSnapshot> readUserData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .snapshots();
  }

  //read category
  Stream<QuerySnapshot> readCategories() {
    return FirebaseFirestore.instance
        .collection("shop_categories")
        .orderBy("priority", descending: true)
        .snapshots();
  }

  // read products
  //Product
  Stream<QuerySnapshot> readProducts() {
    return FirebaseFirestore.instance
        .collection("shop_products")
        .orderBy("category", descending: true)
        .snapshots();
  }

//reduce Quantity
  Future reduceQuantity(
      {required String productId, required int quantity}) async {
    await FirebaseFirestore.instance
        .collection("shop_products")
        .doc(productId)
        .update({"maxQuantity": FieldValue.increment(-quantity)});
  }

  //cart
  //read cart
  Stream<QuerySnapshot> readCart() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("cart")
        .snapshots();
  }

//add cart data
  Future addToCart({required CartModel cartData}) async {
    try {
      String cartId = cartData.cartId;

      DocumentReference cartRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("cart")
          .doc(cartId);

      DocumentSnapshot doc = await cartRef.get();

      if (doc.exists) {
        await cartRef.update({
          "quantity": FieldValue.increment(1),
        });
      } else {
        await cartRef.set(cartData.toJson());
      }
    } on FirebaseException catch (e) {
      print("Firebase exception: ${e.code}");
    }
  }

  Future deleteItemFromCart({required String cartId}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("cart")
        .doc(cartId)
        .delete();
  }

  Future emptyCard() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("cart")
        .get()
        .then((value) {
      for (DocumentSnapshot ds in value.docs) {
        ds.reference.delete();
      }
    });
  }

  Future decreaseCount({required String cartId}) async {
    DocumentReference cartRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("cart")
        .doc(cartId);

    DocumentSnapshot doc = await cartRef.get();

    if (doc.exists && (doc.data() as Map<String, dynamic>)["quantity"] > 1) {
      await cartRef.update({"quantity": FieldValue.increment(-1)});
    } else {
      await cartRef.delete(); // Remove item if quantity becomes 0
    }
  }

  //search product by docs ids
  Stream<QuerySnapshot> searchProducts(List<String> docIds) {
    return FirebaseFirestore.instance
        .collection("shop_products")
        .where(FieldPath.documentId, whereIn: docIds)
        .snapshots();
  }

  //wishlist

  //readwishlist
  Stream<QuerySnapshot> readWishlist() {
    try {
      if (user == null) {
        print("User is not logged in");
        return const Stream.empty();
      }
      return FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("wishlist")
          .snapshots();
    } on FirebaseException catch (e) {
      print("firebase exception on read wishlist: ${e.code}");
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }

// Add to wishlist
  Future addToWishlist({required String productId}) async {
    try {
      if (user == null) {
        print("User is not logged in");
        return;
      }
      final wishlistRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("wishlist")
          .doc(productId);

      final doc = await wishlistRef.get();
      if (!doc.exists) {
        await wishlistRef.set({
          "product_id": productId,
        });
      } else {
        print("Product already exists in wishlist");
      }
    } on FirebaseException catch (e) {
      print("firebase exception on add wishlist : ${e.code}");
    }
  }

// Delete from wishlist
  Future deleteItemFromWishlist({required String productId}) async {
    try {
      if (user == null) {
        print("User is not logged in");
        return;
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("wishlist")
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      print("firebase exception on delete wishlist : ${e.code}");
    }
  }

  // profle for saving address
  Future addAddress({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("address")
        .add(data);
  }

  Future updateAddress(
      {required String doId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("address")
        .doc(doId)
        .update(data);
  }

  Future deleteAddress({
    required String doId,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("address")
        .doc(doId)
        .delete();
  }

  Stream<QuerySnapshot> readAddress() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("address")
        .snapshots();
  }

  //Discount
  // DISCOUNTS
// read discount coupons
  Stream<QuerySnapshot> readDiscounts() {
    return FirebaseFirestore.instance
        .collection("shop_coupons")
        .orderBy("discount", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> verifyDiscount({required String code}) {
    print("seraching for code : $code");
    return FirebaseFirestore.instance
        .collection("shop_coupons")
        .where("code", isEqualTo: code)
        .get();
  }

  // create a new order
  Future createOrder({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_orders").add(data);
  }

  // update the status of order
  Future updateOrderStatus(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_orders")
        .doc(docId)
        .update(data);
  }

  // read the order data of specific user
  Stream<QuerySnapshot> readOrders() {
    return FirebaseFirestore.instance
        .collection("shop_orders")
        .where("user_id", isEqualTo: user!.uid)
        .orderBy("created_at", descending: true)
        .snapshots();
  }
  //promos
    //read promos
  Stream<QuerySnapshot> readPromos() {
    return FirebaseFirestore.instance
        .collection("shop_promos")
        .orderBy("category",descending: true)
        .snapshots();
  }





}
