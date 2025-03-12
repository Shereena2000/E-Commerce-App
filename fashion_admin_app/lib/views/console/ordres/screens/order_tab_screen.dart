
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/order_card.dart';
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

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 5,
                  ),
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
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
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
            },
          );
        },
      ),
    );
  }
}
