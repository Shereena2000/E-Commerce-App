import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/controllers/profile_service.dart';
import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot> profiles = [];
  StreamSubscription<QuerySnapshot>? _profileSubscription;
  int totalProfiles = 0;
  bool isLoading=true;
  ProfileProvider() {
    getProfiles();
  }
  void getProfiles() {
    _profileSubscription?.cancel();
    isLoading=true;
    _profileSubscription = ProfileService().readProfiles().listen((snapshot) {
      profiles = snapshot.docs;
      totalProfiles = snapshot.docs.length;
      isLoading=false;
      notifyListeners();
    });
  }
}
