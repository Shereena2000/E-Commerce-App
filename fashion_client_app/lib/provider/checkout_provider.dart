import 'package:fashion_client_app/model/address_model.dart';
import 'package:fashion_client_app/utils/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutProvider extends ChangeNotifier {
  int selectedAddressIndex = 0;
  int discount = 0;
  String discountText = "";
   AddressModel? selectedAddress;

   void clear() {
    selectedAddressIndex = 0;
    discount = 0;
    discountText = "";
    selectedAddress = null;
    notifyListeners();
  }

   void resetDiscount() {
    discount = 0;
    discountText = "";
    notifyListeners();
  }

 void setDefaultAddress(List<AddressModel> addresses) {
    if (addresses.isNotEmpty && selectedAddress == null) {
      selectedAddress = addresses[0]; 
      selectedAddressIndex = 0;
      notifyListeners();
    }
  }
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


  Future<void> initPaymentSheet(BuildContext context, int cost, ) async {
    try {
      if (selectedAddress == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an address.")),
        );
        return;
      }

      final data = await createPaymentIntent(
        name: selectedAddress!.name,
        address: selectedAddress!.address,
        amount: (cost * 100).toString(),
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
  
}
