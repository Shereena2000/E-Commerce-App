
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class OrderProductList extends StatelessWidget {
  const OrderProductList({
    super.key,
    required this.args,
  });

  final OrdersModel args;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: args.products
          .map(
            (e) => Container(
              width: double.infinity,
              padding: EdgeInsets.all(isWeb ? 16.0 : 10.0),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: beigeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: isWeb ? 120 : 80,
                        width: isWeb ? 120 : 80,
                        child: Image.network(e.image),
                      ),
                      liteSpacing,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name.titleCase,
                              style: TextStyle(
                                fontSize: isWeb ? 16 : 14,
                              ),
                            ),
                            Text(
                              "Price : ₹${e.single_price.toString()} x ${e.quantity.toString()} quantity",
                            ),
                            Text("Size : ${e.size}"),
                            Text("Color : ${e.color}"),
                            Text("Quantity : ${e.quantity.toString()}"),
                            Text(
                              "Total ₹${e.total_price.toString()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isWeb ? 16 : 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}