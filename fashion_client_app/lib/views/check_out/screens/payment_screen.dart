import 'package:flutter/material.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';

class PaymentScreen extends StatelessWidget {
  final Function(int) goToPage; // Accept navigation function

  const PaymentScreen({super.key, required this.goToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          text: "Confirm Payment",
          onPressed: () => goToPage(2), // Navigate to Confirmation Screen
        ),
      ),
    );
  }
}
