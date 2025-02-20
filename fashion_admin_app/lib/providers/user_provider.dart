import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  StreamSubscription<DocumentSnapshot>? _userSubscription;
  String name = "User";
  String email = "";
  // load user profile data
  UserProvider() {
    loadUserData();
  }
  void loadUserData() {
    _userSubscription?.cancel();
    _userSubscription = DbService().readUserData().listen((snapshot) {
      print(snapshot.data());

      // Extract data from the snapshot
      final UserModel data =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      name = data.name;
      email = data.email;
      notifyListeners();
    });
  }
  void cancelProvider(){
   _userSubscription?.cancel();
  }
  @override
  void dispose() {
    cancelProvider();
    // TODO: implement dispose
    super.dispose();
  }
}
