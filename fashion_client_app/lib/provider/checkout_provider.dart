import 'package:fashion_client_app/model/address_model.dart';
import 'package:flutter/material.dart';

class CheckoutProvider extends ChangeNotifier {
  int selectedAddressIndex = 0;
  int discount = 0;
  String discountText = "";
   AddressModel? selectedAddress;

   void setSelectedAddress(int index, AddressModel address) {
    selectedAddressIndex = index;
    selectedAddress = address;
    notifyListeners();
  }
  void discountCalculator(int disPercent, int totalCost) {
    discount = (disPercent * totalCost) ~/ 100;
    discountText = "A discount of $disPercent% has been applied.";
    notifyListeners();
  }

  void setDiscountText(String text) {
    discountText = text;
    notifyListeners();
  }
}
