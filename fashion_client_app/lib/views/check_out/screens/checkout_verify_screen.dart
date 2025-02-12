import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/address_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/checkout_provider.dart';
import 'package:fashion_client_app/provider/profile_provider.dart';
import 'package:fashion_client_app/utils/payment.dart';
import 'package:fashion_client_app/views/address/add_address_screen.dart';
import 'package:fashion_client_app/widgets/coupon_input.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:provider/provider.dart';

class CheckoutVerifyScreen extends StatelessWidget {
  final Function(int) goToPage;

  CheckoutVerifyScreen({super.key, required this.goToPage});

  Future<void> initPaymentSheet(BuildContext context, int cost) async {
    try {
      final checkoutProvider =
          Provider.of<CheckoutProvider>(context, listen: false);
      if (checkoutProvider.selectedAddress == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an address.")),
        );
        return;
      }

      // 1. Create payment intent on the server
      final data = await createPaymentIntent(
        name: checkoutProvider.selectedAddress!.name,
        address: checkoutProvider.selectedAddress!.address,
        amount: (cost * 100).toString(),
      );

      // 2. Initialize the payment sheet
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer3<ProfileProvider, CartProvider, CheckoutProvider>(
        builder: (context, userData, cartData, checkoutData, child) {
          List<AddressModel> address =
              AddressModel.fromJsonList(userData.profiles);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Delivery To", style: mediumText),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: address.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: checkoutData.selectedAddressIndex == index
                            ? Colors.green[50]
                            : Colors.white,
                        child: ListTile(
                          leading: Radio(
                            value: index,
                            groupValue: checkoutData.selectedAddressIndex,
                            onChanged: (value) {
                              checkoutData.setSelectedAddress(
                                  index, address[index]);
                            },
                          ),
                          title: Text(
                              "${address[index].name}, ${address[index].address}"),
                          subtitle: Text(
                              "${address[index].state}, ${address[index].pinCode}"),
                          trailing: PopupMenuButton(
                            color: whiteColor,
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddAddressScreen(
                                          id: address[index].id,
                                          isModify: true,
                                          name: address[index].name,
                                          email: address[index].email,
                                          address: address[index].address,
                                          pinCode: address[index].pinCode,
                                          state: address[index].state,
                                          phoneNumber: address[index].phone,
                                          addresslabel:
                                              address[index].addressLabel,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Edit"),
                                ),
                              ),
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    DbService()
                                        .deleteAddress(doId: address[index].id);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text("Use a different address"),
                    onTap: () {
                      Navigator.pushNamed(context, '/addDetails');
                    },
                  ),
                  const Divider(),
                  CouponInput(),
                  liteSpacing,
                  checkoutData.discountText.isEmpty
                      ? Container()
                      : Text(checkoutData.discountText),
                  liteSpacing,
                  const Divider(),
                  moderateSpacing,
                  Card(
                    color: whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          buildSummaryRow("Total Quantity of Product",
                              cartData.totalQuantity.toString()),
                          buildSummaryRow(
                              "Sub Total", cartData.totalCost.toString()),
                          buildSummaryRow("Extra Discount",
                              checkoutData.discount.toString()),
                          liteSpacing,
                          buildSummaryRow("Total Payable",
                              "${cartData.totalCost - checkoutData.discount}",
                              isBold: true),
                        ],
                      ),
                    ),
                  ),
                  largerSpacing,
                  Center(
                    child: CustomButton(
                      text: "Continue To Payment",
                      onPressed: () async {
                        final checkoutProvider = Provider.of<CheckoutProvider>(
                            context,
                            listen: false);
                        if (checkoutProvider.selectedAddress == null ||
                            checkoutProvider.selectedAddress!.address.isEmpty ||
                            checkoutProvider.selectedAddress!.phone.isEmpty ||
                            checkoutProvider.selectedAddress!.name.isEmpty ||
                            checkoutProvider.selectedAddress!.email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Please fill your delivery details.")),
                          );
                          return;
                        }

                        await initPaymentSheet(context,
                            cartData.totalCost - checkoutData.discount);

                        try {
                          await stripe.Stripe.instance.presentPaymentSheet();
                          final cart =
                              Provider.of<CartProvider>(context, listen: false);
                          User? currentUser = FirebaseAuth.instance.currentUser;
                          List product = [];
                          for (int i = 0; i < cart.product.length; i++) {
                            product.add({
                              "id": cart.product[i].id,
                              "name": cart.product[i].name,
                              "image": cart.product[i].images[0],
                              "single_price": cart.product[i].newPrice,
                              "total_price": cart.product[i].newPrice *
                                  cart.cart[i].quantity,
                              "quantity": cart.cart[i].quantity
                            });
                          }
                          Map<String, dynamic> orderData = {
                            "user_id": currentUser!.uid,
                            "name": checkoutProvider.selectedAddress!.name,
                            "email": checkoutProvider.selectedAddress!.email,
                            "address":
                                checkoutProvider.selectedAddress!.address,
                            "phone": checkoutProvider.selectedAddress!.phone,
                            "discount": checkoutData.discount,
                            "total": cart.totalCost - checkoutData.discount,
                            "products": product,
                            "status": "PAID",
                            "created_at": DateTime.now().millisecondsSinceEpoch
                          };

                          // creating new order
                          await DbService().createOrder(data: orderData);
                          for (int i = 0; i < cart.product.length; i++) {
                            DbService().reduceQuantity(
                                productId: cart.product[i].id,
                                quantity: cart.cart[i].quantity);
                          }
                          await DbService().emptyCard();
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Payment Done",
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          print("Payment sheet error: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Payment Failed",
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSummaryRow(String label, String value, {bool isBold = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      ),
      Text(
        value,
        style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      ),
    ],
  );
}
