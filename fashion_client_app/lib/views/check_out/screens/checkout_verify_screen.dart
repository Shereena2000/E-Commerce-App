import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/controllers/payment_service.dart';
import 'package:fashion_client_app/model/address_model.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/checkout_provider.dart';
import 'package:fashion_client_app/provider/address_provider.dart';
import 'package:fashion_client_app/views/check_out/widgets/add_address_button.dart';
import 'package:fashion_client_app/views/check_out/widgets/buid_summary_row.dart';
import 'package:fashion_client_app/views/check_out/widgets/build_address_card.dart';
import 'package:fashion_client_app/widgets/coupon_input.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutVerifyScreen extends StatelessWidget {
  const CheckoutVerifyScreen({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CheckoutProvider>(context, listen: false).resetDiscount();
    });

    return Scaffold(
      appBar: const CustomMainAppBar(),
      body: Consumer3<AddressProvider, CartProvider, CheckoutProvider>(
        builder: (context, userData, cartData, checkoutData, child) {
          List<AddressModel> address =
              AddressModel.fromJsonList(userData.profiles);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            checkoutData.setDefaultAddress(address);
          });
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
                      return buildAddressCard(context, checkoutData, address, index);
                      
                    },
                  ),
                  const AddAddressButton(),
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
                        PaymentService().processPayment(context, checkoutData, cartData);
                        
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



