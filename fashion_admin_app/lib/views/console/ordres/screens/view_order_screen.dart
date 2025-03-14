
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/modify_order_showdialog.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/order_detailed_card.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/order_product_list.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/order_summary_card.dart';
import 'package:fashion_admin_app/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';

class ViewOrderScreen extends StatelessWidget {
  const ViewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrdersModel;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600; // Adjust this threshold as needed

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? screenWidth * 0.1 : 16.0,
            vertical: 16.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWeb ? 800 : screenWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderDetailsCard(args: args),
                  moderateSpacing,
                  OrderProductList(args: args),
                  moderateSpacing,
                  OrderSummaryCard(args: args),
                  moderateSpacing,
                  Center(
                    child: CustomOutlineButton(
                      text: "Modify Order",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ModifyOrder(
                            order: args,
                          ),
                        );
                      },
                    ),
                  ),
                  moderateSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}