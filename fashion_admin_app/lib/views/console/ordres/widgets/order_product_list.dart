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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: args.products
          .map(
            (e) => Container(
              width: double.infinity,
              padding:const EdgeInsets.all(10),
              margin:const EdgeInsets.all(4),
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
                        height: 80,
                        width: 80,
                        child: Image.network(e.image),
                      ),
                      liteSpacing,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.name.titleCase),
                          Text(
                            "Price : ₹${e.single_price.toString()} x ${e.quantity.toString()} quantity",
                          ),
                          Text(
                            "Quantity :  ${e.quantity.toString()}",
                          ),
                          Text(
                            "Total ₹${e.total_price.toString()}",
                          ),
                        ],
                      )),
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
