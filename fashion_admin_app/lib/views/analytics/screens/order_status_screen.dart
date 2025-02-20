import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/views/analytics/widgets/order_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildOrderStatus() {
    return Consumer<AdminProviders>(
      builder: (context, adminProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           const  Center(
                child:  Text('Order Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              largerSpacing,
              SizedBox(
                height: MediaQuery.of(context).size.height/2-40,
                child: OrderStatusPieChart(
                  delivered: adminProvider.ordersDelivered,
                  cancelled: adminProvider.ordersCancelled,
                  shipped: adminProvider.ordersShipped,
                  pending: adminProvider.orderPendingProcess,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
