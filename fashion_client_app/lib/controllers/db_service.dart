import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {

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

}