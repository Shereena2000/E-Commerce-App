import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  StreamSubscription<DocumentSnapshot>? _profileSubscription;
  bool isLoading = true;

  String name = "User";
  String address = "";
  String phone = "";
  String email = "";
  String pinCode = "";
  String state = "";
  String? addressLabel = "";

  ProfileProvider() {
    loadProfileData();
  }

  // Method to load profile data
  void loadProfileData() {
    _profileSubscription?.cancel(); // Cancel any existing subscription
    isLoading = true;
    _profileSubscription = DbService().readUserData().listen((snapshot) {
      if (snapshot.exists) {
        // Extract data from the snapshot
        final profileData = snapshot.data() as Map<String, dynamic>;
        final profile = ProfileModel.fromJson(profileData, snapshot.id);

        // Update the provider's state
        name = profile.name;
        address = profile.address;
        phone = profile.phone;
        email = profile.email;
        pinCode = profile.pinCode;
        state = profile.state;
        addressLabel = profile.addressLabel;
        isLoading = false;

        // Notify listeners to update the UI
        notifyListeners();
      } else {
        print("User profile not found");
      }
    });
  }

  // Dispose the subscription when the provider is no longer needed
  @override
  void dispose() {
    _profileSubscription?.cancel();
    super.dispose();
  }

//   List<QueryDocumentSnapshot> profiles = [];
//   StreamSubscription<QuerySnapshot>? _profileSubscription;
//   int totalProfiles = 0;
//   bool isLoading = true;
//   ProfileProvider() {
//     getProfiles();
//   }
//   void getProfiles() {
//     _profileSubscription?.cancel();
//     isLoading = true;
//     _profileSubscription = ProfileService().readProfiles().listen((snapshot) {
//       profiles = snapshot.docs;
//       totalProfiles = snapshot.docs.length;
//       isLoading = false;
//       notifyListeners();
//     });
//   }
}
