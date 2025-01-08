import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
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
}
