import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:flutter/material.dart';

class AdminProviders extends ChangeNotifier {
  List<QueryDocumentSnapshot> categories=[];
  StreamSubscription<QuerySnapshot>?_categorySubscription;
  int totalCategories=0;
  AdminProviders(){
    getCategories();
  }
  void getCategories(){
    _categorySubscription?.cancel();
    _categorySubscription=DbService().readCategories().listen((snapshot){
      categories=snapshot.docs;
      totalCategories=snapshot.docs.length;
      notifyListeners();
    });
  }
}