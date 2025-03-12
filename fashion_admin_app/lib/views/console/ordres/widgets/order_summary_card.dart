import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:fashion_admin_app/utils/status_icon.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.args,
  });

  final OrdersModel args;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    return Container(
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
                "Order Summary",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isWeb ? 18 : 16,
                ),
              ),
              liteSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discount : ₹${args.discount}",
                    style: TextStyle(
                      fontSize: isWeb ? 16 : 14,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total : ₹${args.total}",
                    style: TextStyle(
                      fontSize: isWeb ? 16 : 14,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isWeb ? 18 : 16,
                    ),
                  ),
                  statusIcon(args.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

