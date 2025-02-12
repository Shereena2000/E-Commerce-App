import 'package:fashion_admin_app/models/order_model.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/order_card.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final List<OrdersModel> orders;
  final int Function(List<OrderProductModel>) totalQuantityCalculator;

  const OrderList({
    super.key,
    required this.orders,
    required this.totalQuantityCalculator,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
          totalQuantityCalculator: totalQuantityCalculator,
          onTap: () {
            Navigator.pushNamed(context, "/vieworder", arguments: orders[index]);
          },
        );
      },
    );
  }
}
