import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
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
}
