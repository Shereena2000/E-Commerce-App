import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  StreamSubscription<DocumentSnapshot>? _userSubscription;
  
  String name = "User";
  String email = "";
  // load user profile data
  UserProvider(){
    loadUserData();
  }
  void loadUserData() {
    _userSubscription?.cancel();
    _userSubscription = DbService().readUserData().listen((snapshot) {
      print(snapshot.data());
 if (snapshot.exists && snapshot.data() != null) {
      // Extract data from the snapshot
      final UserModel data =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
          name=data.name;
          email=data.email;
          notifyListeners();}else {

        name = "User";
        email = "";
        notifyListeners();
      }
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
// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';

// class UserProvider with ChangeNotifier {
//   String _name = "User";
//   String _email = "";
//   StreamSubscription<User?>? _authSubscription;
//   StreamSubscription<DocumentSnapshot>? _userSubscription;

//   String get name => _name;
//   String get email => _email;

//   UserProvider() {
//     _setupAuthListener();
//   }

//   void _setupAuthListener() {
//     _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
//       if (user != null) {
//         _loadUserData(user.uid);
//       } else {
//         clearUserData();
//       }
//     });
//   }

//   void _loadUserData(String uid) {
//     _userSubscription?.cancel();
//     _userSubscription = FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .snapshots()
//         .listen((snapshot) {
//       if (snapshot.exists) {
//         _name = snapshot.data()?['name'] ?? "User";
//         _email = snapshot.data()?['email'] ?? "";
//       } else {
//         _name = "User";
//         _email = "";
//       }
//       notifyListeners();
//     });
//   }

//   void clearUserData() {
//     _userSubscription?.cancel();
//     _name = "User";
//     _email = "";
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _authSubscription?.cancel();
//     _userSubscription?.cancel();
//     super.dispose();
//   }
// }