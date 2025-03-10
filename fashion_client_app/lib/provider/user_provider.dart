import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  StreamSubscription<DocumentSnapshot>? _userSubscription;

  String name = "User";
  String email = "";
  // load user profile data
  UserProvider() {
   // In provider constructor:
FirebaseAuth.instance.authStateChanges().listen((User? user) {
  if (user != null) {
    // User is signed in, load data
  loadUserData();
  } else {
    // User is signed out, clear data
  cancelProvider();
  }
});
  }
  void reloadData() {
  if (FirebaseAuth.instance.currentUser != null) {
    loadUserData();
  }
}
  void loadUserData() {
    _userSubscription?.cancel();
    _userSubscription = DbService().readUserData().listen((snapshot) {
      print(snapshot.data());
      if (snapshot.exists && snapshot.data() != null) {
        // Extract data from the snapshot
        final UserModel data =
            UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
        name = data.name;
        email = data.email;
        notifyListeners();
      } else {
        name = "User";
        email = "";
        notifyListeners();
      }
    });
  }

  void clearUserData() {
    name = "User";
    email = "";
    _userSubscription?.cancel();
    _userSubscription = null;
    notifyListeners();
  }

  void cancelProvider() {
    _userSubscription?.cancel();
    _userSubscription = null;
    clearUserData();
  }

  @override
  void dispose() {
    cancelProvider();
    // TODO: implement dispose
    super.dispose();
  }
}
