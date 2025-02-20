import 'package:fashion_admin_app/models/order_model.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderTabScreen extends StatelessWidget {
  const OrderTabScreen({super.key});

  int totalQuantityCalculator(List<OrderProductModel> products) {
    return products.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminProviders>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (value.orders.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          List<OrdersModel> orders = OrdersModel.fromJsonList(value.orders);

          return OrderList(
            orders: orders,
            totalQuantityCalculator: totalQuantityCalculator,
          );
        },
      ),
    );
  }
}
