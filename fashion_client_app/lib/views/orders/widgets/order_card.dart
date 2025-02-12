import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/model/order_model.dart';
import 'package:fashion_client_app/utils/status_icon.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrdersModel order;
  final int Function(List<OrderProductModel>) totalQuantityCalculator;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.totalQuantityCalculator,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: whiteColor,
        child: ListTile(
          onTap: onTap,
          title: Text(
            "${totalQuantityCalculator(order.products)} Items Worth ₹ ${order.total}",
          ),
          subtitle: Text(
            "Ordered on ${DateTime.fromMillisecondsSinceEpoch(order.created_at)}",
          ),
          trailing: statusIcon(order.status),
        ),
      ),
    );
  }
}
