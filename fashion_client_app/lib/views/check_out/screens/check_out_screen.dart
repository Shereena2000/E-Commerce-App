

import 'package:fashion_client_app/views/check_out/screens/checkout_verify_screen.dart';
import 'package:fashion_client_app/views/check_out/screens/confirmation_screen.dart';
import 'package:fashion_client_app/views/check_out/screens/payment_screen.dart';
import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late PageController _pageController; // Define PageController

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Initialize PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController to prevent memory leaks
    super.dispose();
  }

  void goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/logo.png",
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping
              children: [
                CheckoutVerifyScreen(goToPage: goToPage),
                PaymentScreen(goToPage: goToPage),
                ConfirmationScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget checkoutStep() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Delivery To", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           Text("Sheerena\nshereenamj340@gmail.com\nXYZ, ABCD, 3344"),
//           SizedBox(height: 16),
//           TextField(decoration: InputDecoration(labelText: "Have a coupon?")),
//           SizedBox(height: 16),
//           Text("Total: \$300\nDiscount: \$35\nTotal Payable: \$265"),
       
//    Expanded(child: Center(child: CustomButton(text: "Continue To Payment", onPressed: () => _goToPage(1),)))
           
        
//         ],
//       ),
//     );
//   }


  
//   Widget _paymentStep() {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("CHOOSE PAYMENT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ListTile(title: Text("Credit / Debit Card"), leading: Radio(value: 1, groupValue: 1, onChanged: (_) {})),
//           ListTile(title: Text("UPI"), leading: Radio(value: 2, groupValue: 1, onChanged: (_) {})),
//           ListTile(title: Text("Net Banking"), leading: Radio(value: 3, groupValue: 1, onChanged: (_) {})),
//           ListTile(title: Text("Cash on Delivery"), leading: Radio(value: 4, groupValue: 1, onChanged: (_) {})),
//           Spacer(),
//         Expanded(child: Center(child: CustomButton(text: "pay", onPressed: () => _goToPage(2),)))
         
           
//         ],
//       ),
//     );
//   }

//   Widget _confirmationStep() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.check_circle, color: Colors.green, size: 50),
//           SizedBox(height: 8),
//           Text("Successful!", style: TextStyle(fontSize: 20, color: Colors.green)),
//           Text("Your order has been confirmed. We will send a confirmation email shortly."),
//           SizedBox(height: 16),
//           Expanded(child: Center(child: CustomButton(text:"Continue Shopping", onPressed: (){}),))
         
//         ],
//       ),
//     );
//   }
// }
