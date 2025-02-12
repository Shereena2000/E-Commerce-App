
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    super.key,
    required this.args,
  });

  final OrdersModel args;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: beigeColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order ID: ${args.id}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              liteSpacing,
              Text(
                  "Ordered On: ${DateTime.fromMillisecondsSinceEpoch(args.created_at)}"),
              liteSpacing,
              Text("Order By: ${args.name}"),
              liteSpacing,
              Text("Phone No: ${args.phone}"),
              liteSpacing,
              Text("Delivery Address: ${args.address}"),
            ],
          ),
        ),
      ),
    );
  }
}
