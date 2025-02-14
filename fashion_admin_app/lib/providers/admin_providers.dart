import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:flutter/material.dart';

class AdminProviders extends ChangeNotifier {
  List<QueryDocumentSnapshot> categories = [];
  StreamSubscription<QuerySnapshot>? _categorySubscription;
  List<QueryDocumentSnapshot> products = [];
  StreamSubscription<QuerySnapshot>? _productsSubscription;
  List<QueryDocumentSnapshot> orders = [];
  StreamSubscription<QuerySnapshot>? _ordersSubscription;
  List<QueryDocumentSnapshot> promos = [];
  StreamSubscription<QuerySnapshot>? _promosSubscription;
  int totalCategories = 0;
  int totalProducts = 0;
  int totalOrders = 0;
  int ordersDelivered = 0;
  int ordersCancelled = 0;
  int ordersShipped = 0;
  int orderPendingProcess = 0;

  bool isLoading = true;
  bool isLoadingProducts = true;
  AdminProviders() {
    getCategories();
    getProducts();
    readOrders();
    getPromos();
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

  void readOrders() {
    _ordersSubscription?.cancel();
    _ordersSubscription = DbService().readOrders().listen((snapshot) {
      orders = snapshot.docs;
      totalOrders = snapshot.docs.length;
      setOrderStatusCount();
      notifyListeners();
    });
  }

  void setOrderStatusCount() {
    ordersDelivered = 0;
    ordersCancelled = 0;
    ordersShipped = 0;
    orderPendingProcess = 0;
    for (int i = 0; i < orders.length; i++) {
      if (orders[i]["status"] == "DELIVERED") {
        ordersDelivered++;
      } else if (orders[i]["status"] == "CANCELLED") {
        ordersCancelled++;
      } else if (orders[i]["status"] == "SHIPPED") {
        ordersShipped++;
      } else {
        orderPendingProcess++;
      }
    }
    notifyListeners();
  }

  void getPromos() {
    _promosSubscription?.cancel();
    isLoading = true;

    _promosSubscription = DbService().readPromos().listen((snapshot) {
      promos = snapshot.docs;

      isLoading = false;
      notifyListeners();
    });
  }
}
