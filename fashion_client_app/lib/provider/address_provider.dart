import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/address_form_data.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
class AddressProvider extends ChangeNotifier {
  AddressProvider() {
    getProfiles();
  }

  // Store form data for each address instance
  final Map<String, AddressFormData> _formDataMap = {};
  List<QueryDocumentSnapshot> profiles = [];
  StreamSubscription<QuerySnapshot>? _profileSubscription;
  int totalProfiles = 0;
  bool isLoading = true;

  // Get form data for specific instance
  AddressFormData getFormData(String id) {
    return _formDataMap[id] ?? AddressFormData(
      addressLabel: 'Home',
      state: 'state 1',
    );
  }
   void initializeFormData(String id, {String? state, String? addressLabel}) {
    if (!_formDataMap.containsKey(id)) {
      _formDataMap[id] = AddressFormData(
        addressLabel: addressLabel ?? 'Home',
        state: state ?? 'state 1',
      );
    }
  }

  // Update form data
  void updateFormData(String id, {String? state, String? addressLabel}) {
    final currentData = getFormData(id);
    _formDataMap[id] = AddressFormData(
      addressLabel: addressLabel ?? currentData.addressLabel,
      state: state ?? currentData.state,
    );
    notifyListeners();
  }

  // Clear form data
  void clearFormData(String id) {
    _formDataMap.remove(id);
    notifyListeners();
  }

  void getProfiles() {
    _profileSubscription?.cancel();
    isLoading = true;
    _profileSubscription = DbService().readAddress().listen((snapshot) {
      profiles = snapshot.docs;
      totalProfiles = snapshot.docs.length;
      isLoading = false;
      notifyListeners();
    });
  }





Future<void> getLocation(BuildContext context, TextEditingController addressController, TextEditingController pinCodeController) async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
    
      print('Location permissions are denied');
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {

    print('Location permissions are permanently denied, please enable them in settings');
    await Geolocator.openAppSettings(); 
    return;
  }


  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  
  print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      String pinCode = place.postalCode ?? '';

    
      addressController.text = address;
      pinCodeController.text = pinCode;

      
      notifyListeners();
    }
  } catch (e) {
    print("Error fetching address: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error fetching address: ${e.toString()}"))
    );
  }
}


  Future<void> handleSubmit({
    required GlobalKey<FormState> formKey,
    required bool isModify,
    required String id,
    required String name,
    required String email,
    required String addAddress,
    required String pinCode,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      final formData = getFormData(id);
      
      final data = {
        "name": name,
        "email": email,
        "address": addAddress,
        "pinCode": pinCode,
        "state": formData.state,
        "phoneNumber": phoneNumber,
        "addresslabel": formData.addressLabel,
      };

      try {
        if (isModify) {
          await DbService().updateAddress(doId: id, data: data);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Address Updated"))
          );
        } else {
          await DbService().addAddress(data: data);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Address Added"))
          );
        }
        
        clearFormData(id);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}"))
        );
      }
    }
  }

  @override
  void dispose() {
    _profileSubscription?.cancel();
    _formDataMap.clear();
    super.dispose();
  }
}



