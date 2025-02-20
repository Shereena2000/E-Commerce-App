import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
//ad the user to firebase
 User? user = FirebaseAuth.instance.currentUser;


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
  //read user current user data
  Stream<DocumentSnapshot> readUserData() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .snapshots();
  }

  //Categories
  Stream<QuerySnapshot> readCategories() {
    return FirebaseFirestore.instance
        .collection("shop_categories")
        .orderBy("priority", descending: true)
        .snapshots();
  }

  Future createCategories({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_categories").add(data);
  }

  Future updateCategoris(
      {required String doId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_categories")
        .doc(doId)
        .update(data);
  }

  Future deleteCategories({required String doId}) async {
    await FirebaseFirestore.instance
        .collection("shop_categories")
        .doc(doId)
        .delete();
  }

  //Product
  Stream<QuerySnapshot> readProducts() {
    return FirebaseFirestore.instance
        .collection("shop_products")
        .orderBy("category", descending: true)
        .snapshots();
  }

  Future createProducts({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_products").add(data);
  }

  Future updateProducts(
      {required String doId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_products")
        .doc(doId)
        .update(data);
  }

  Future deleteProducts({required String doId}) async {
    await FirebaseFirestore.instance
        .collection("shop_products")
        .doc(doId)
        .delete();
  }

  //COUPON CODE
  // read coupon code from database
  Stream<QuerySnapshot> readCouponCode() {
    return FirebaseFirestore.instance.collection("shop_coupons").snapshots();
  }

  // create new coupon code
  Future createCouponCode({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_coupons").add(data);
  }

  // update coupon code
  Future updateCouponCode(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_coupons")
        .doc(docId)
        .update(data);
  }

  // delete coupon code
  Future deleteCouponCode({required String docId}) async {
    await FirebaseFirestore.instance
        .collection("shop_coupons")
        .doc(docId)
        .delete();
  }

  // read the orders
  Stream<QuerySnapshot> readOrders() {
    return FirebaseFirestore.instance
        .collection("shop_orders")
        .orderBy("created_at", descending: true)
        .snapshots();
  }
    Future updateOrderStatus(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_orders")
        .doc(docId)
        .update(data);
  }

  //promos
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   // Read Promos (Real-time updates)
  Stream<QuerySnapshot> readPromos() {
    return _firestore.collection("shop_promos").  orderBy( "category",).snapshots();
  }

// Create a new promo
Future<String?> createPromos({required Map<String, dynamic> data}) async {
  try {
    DocumentReference docRef = await _firestore.collection("shop_promos").add(data);
    return docRef.id; // Return document ID after creation
  } catch (e) {
    print("Error creating promo: $e");
    return null;
  }
}

// Update an existing promo
Future<void> updatePromos({required String docId, required Map<String, dynamic> data}) async {
  try {
    await _firestore.collection("shop_promos").doc(docId).update(data);
  } catch (e) {
    print("Error updating promo: $e");
  }
}
  // Delete a promo
  Future<void> deletePromos({required String docId}) async {
    try {
      await _firestore.collection("shop_promos").doc(docId).delete();
    } catch (e) {
      print("Error deleting promo: $e");
    }
  }
   
}

