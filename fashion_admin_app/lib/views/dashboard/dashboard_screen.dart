import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:fashion_admin_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAppBar(title: "Dashboard"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<AdminProviders>(builder: (context, value, child) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          beigeColor,
                          Color.fromARGB(255, 216, 216, 216)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Card(
                      color: beigeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                          },
                          children: [
                            _buildTableRow("Total Categories",
                                "${value.categories.length}"),
                            _buildTableRow(
                                "Total Products", "${value.products.length}"),
                            _buildTableRow(
                              "Total Orders",
                              "${value.totalOrders}",
                            ),
                            _buildTableRow(
                                "Orders Shipped", "${value.ordersShipped}"),
                            _buildTableRow(
                                "Orders Delivered", "${value.ordersDelivered}"),
                            _buildTableRow(
                                "Total Cancelled", "${value.ordersCancelled}"),
                            _buildTableRow(
                              "Orders Not Shipped Yet",
                              "${value.orderPendingProcess}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Lottie.asset(
                  "assets/animation.json",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: brownColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: brownColor),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
