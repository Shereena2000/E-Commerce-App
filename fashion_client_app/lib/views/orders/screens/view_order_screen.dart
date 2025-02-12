import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/order_model.dart';
import 'package:fashion_client_app/views/orders/widgets/order_details_card.dart';
import 'package:fashion_client_app/views/orders/widgets/order_product_list.dart';
import 'package:fashion_client_app/views/orders/widgets/order_summary_card.dart';
import 'package:fashion_client_app/widgets/additional_confirm.dart';
import 'package:fashion_client_app/widgets/custom_app_bar.dart';
import 'package:fashion_client_app/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';

class ViewOrderScreen extends StatelessWidget {
  const ViewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrdersModel;

    return Scaffold(
      appBar: const CustomAppBar(title: "Order Summary"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetailsCard(args: args),
              moderateSpacing,       
              OrderProductList(args: args),
              const SizedBox(height: 16),
              OrderSummaryCard(args: args),
              moderateSpacing,
              args.status=="PAID" || args.status=="SHIPPED" ? 
              Center(
                child: CustomOutlineButton(
                    text: "Cancel Order",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AdditionalConfirm(
                              contentText:
                                  "After canceling this cannot be changed you need to order again.",
                              onYes: () async {
                                await DbService().updateOrderStatus(
                                    docId: args.id,
                                    data: {"status": "CANCELED"});
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              onNo: () {
                                Navigator.pop(context);
                              }));
                    }),
              ):const SizedBox(),
              moderateSpacing
            ],
          ),
        ),
      ),
    );
  }
}
