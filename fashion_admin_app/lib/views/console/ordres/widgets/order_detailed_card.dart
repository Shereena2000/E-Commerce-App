
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    super.key,
    required this.args,
  });

  final OrdersModel args;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    String formattedDate = DateFormat('dd MMM yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(args.created_at));

    return SizedBox(
      width: double.infinity,
      child: Card(
        color: beigeColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(isWeb ? 24.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order ID: ${args.id}",
                style: TextStyle(
                  fontSize: isWeb ? 18 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              liteSpacing,
              Text("Ordered On: $formattedDate"),
              liteSpacing,
              Text("Order By: ${args.name}"),
              liteSpacing,
              Text("Phone No: ${args.phone}"),
              liteSpacing,
              Text("Delivery Address: ${args.address}"),
              liteSpacing,
              Text("Pin Code: ${args.addressDetails.pinCode}"),
              liteSpacing,
              Text("State: ${args.addressDetails.state}"),
              liteSpacing,
              Text("Address Label: ${args.addressDetails.addressLabel}"),
              liteSpacing,
            ],
          ),
        ),
      ),
    );
  }
}