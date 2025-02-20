import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/provider/checkout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponInput extends StatelessWidget {
  final TextEditingController couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutProvider>(
      builder: (context, checkoutData, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: couponController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              hintText: "Enter Coupon code",
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                  ),
                  onPressed: () async {
                    QuerySnapshot querySnapshot = await DbService()
                        .verifyDiscount(code: couponController.text.toUpperCase());

                    if (querySnapshot.docs.isNotEmpty) {
                      QueryDocumentSnapshot doc = querySnapshot.docs.first;
                      String code = doc.get('code');
                      int percent = doc.get('discount');

                      print('Discount code: $code');
                      checkoutData.discountCalculator(percent, 1000);
                    } else {
                      print('No discount code found');
                      checkoutData.setDiscountText("No discount code found");
                    }
                  },
                  child: const Text("Apply", style: TextStyle(color: blackColor)),
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        );
      },
    );
  }
}
