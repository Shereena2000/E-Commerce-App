import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/model/order_model.dart';
import 'package:fashion_client_app/utils/status_icon.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.args,
  });

  final OrdersModel args;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: whiteColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Order Summary",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              liteSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discount : ₹${args.discount}",
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total : ₹${args.total}",
                  )
                ],
              ),
              const Divider(),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Staus",
                      style: TextStyle(fontWeight: FontWeight.bold)),
               statusIcon(args.status)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


