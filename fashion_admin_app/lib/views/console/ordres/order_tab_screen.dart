import 'package:fashion_admin_app/controllers/db_service.dart';
import 'package:fashion_admin_app/models/order_model.dart';
import 'package:fashion_admin_app/views/console/ordres/widgets/order_list.dart';
import 'package:flutter/material.dart';


class OrderTabScreen  extends StatelessWidget {
  const OrderTabScreen ({super.key});

  int totalQuantityCalculator(List<OrderProductModel> products) {
    return products.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(
        stream: DbService().readOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(snapshot.error.toString())),
              );
            });
            return const Center(child: Text("An error occurred."));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          List<OrdersModel> orders =
              OrdersModel.fromJsonList(snapshot.data!.docs);

          return OrderList(
              orders: orders, totalQuantityCalculator: totalQuantityCalculator);
        },
      ),
    );
  }
}
