import 'package:fashion_client_app/controllers/db_service.dart';
import 'package:fashion_client_app/model/order_model.dart';
import 'package:fashion_client_app/views/orders/widgets/order_list.dart';
import 'package:fashion_client_app/widgets/custom_app_bar.dart';
import 'package:fashion_client_app/widgets/custom_empty_widget.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  int totalQuantityCalculator(List<OrderProductModel> products) {
    return products.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My Orders"),
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
            return const CustomEmptyWidget(text: "No Orders Yet", asset: "assets/purchased.json");
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
