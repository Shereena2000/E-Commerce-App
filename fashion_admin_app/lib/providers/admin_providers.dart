import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:flutter/material.dart';

class AdminProviders extends ChangeNotifier {
  List<QueryDocumentSnapshot> categories = [];
  StreamSubscription<QuerySnapshot>? _categorySubscription;
  List<QueryDocumentSnapshot> products = [];
  StreamSubscription<QuerySnapshot>? _productsSubscription;
  int totalCategories = 0;
  int totalProducts = 0;
  bool isLoading = true;
  bool isLoadingProducts = true;
  AdminProviders() {
    getCategories();
    getProducts();
  }
  void getCategories() {
    _categorySubscription?.cancel();
    isLoading = true;
    _categorySubscription = DbService().readCategories().listen((snapshot) {
      categories = snapshot.docs;
      totalCategories = snapshot.docs.length;
      isLoading = false;
      notifyListeners();
    });
  }

  void getProducts() {
    _productsSubscription?.cancel();
    print("Fetching products from Firestore...");
    isLoadingProducts = true;
    _productsSubscription = DbService().readProducts().listen((snapshot) {
      products = snapshot.docs;
      totalProducts = snapshot.docs.length;
      isLoadingProducts = false;
       print("Products fetched: ${totalProducts}");

    // Debug: Log each product's data
    for (var doc in snapshot.docs) {
      print("Product data: ${doc.data()}");
    }
      notifyListeners();

    });
  }
}
