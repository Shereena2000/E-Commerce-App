
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
    // Get screen width to determine layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Scaffold(
      appBar: const CustomAppBar(title: "Dashboard"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<AdminProviders>(builder: (context, value, child) {
                return Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 1200 : double.infinity,
                  ),
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
                      padding: EdgeInsets.all(isDesktop ? 30.0 : 20.0),
                      child: isDesktop
                          ? _buildDesktopLayout(value)
                          : _buildMobileLayout(value),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: isDesktop ? constraints.maxWidth * 0.5 : constraints.maxWidth,
                    child: Lottie.asset(
                      "assets/animation.json",
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(AdminProviders value) {
    // For desktop, use a grid layout with multiple columns
    return Wrap(
      spacing: 30.0,
      runSpacing: 20.0,
      alignment: WrapAlignment.spaceEvenly,
      children: [
        _buildStatCard("Total Categories", "${value.categories.length}"),
        _buildStatCard("Total Products", "${value.products.length}"),
        _buildStatCard("Total Orders", "${value.totalOrders}"),
        _buildStatCard("Orders Shipped", "${value.ordersShipped}"),
        _buildStatCard("Orders Delivered", "${value.ordersDelivered}"),
        _buildStatCard("Total Cancelled", "${value.ordersCancelled}"),
        _buildStatCard("Orders Not Shipped Yet", "${value.orderPendingProcess}"),
      ],
    );
  }

  Widget _buildMobileLayout(AdminProviders value) {
    // For mobile, use the existing table layout
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: [
        _buildTableRow("Total Categories", "${value.categories.length}"),
        _buildTableRow("Total Products", "${value.products.length}"),
        _buildTableRow("Total Orders", "${value.totalOrders}"),
        _buildTableRow("Orders Shipped", "${value.ordersShipped}"),
        _buildTableRow("Orders Delivered", "${value.ordersDelivered}"),
        _buildTableRow("Total Cancelled", "${value.ordersCancelled}"),
        _buildTableRow("Orders Not Shipped Yet", "${value.orderPendingProcess}"),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: brownColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: brownColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: brownColor,
            ),
          ),
        ],
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