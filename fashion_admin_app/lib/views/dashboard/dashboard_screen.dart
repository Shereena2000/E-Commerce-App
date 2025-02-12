import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: beigeColor,
        title: const Text(
          'Dashboard',
          style: screenText,
        ),
        centerTitle: true,
      ),
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
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(DashboardApp());
// }

// class DashboardApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: DashboardScreen(),
//     );
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//         centerTitle: true,
//         backgroundColor: Colors.blue.shade800,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildGridCards(), // Dashboard Cards
//             SizedBox(height: 20),
//             _buildChartCard(), // Chart Visualization
//           ],
//         ),
//       ),
//     );
//   }

//   // 📌 Grid of Cards to Display Stats
//   Widget _buildGridCards() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       physics: NeverScrollableScrollPhysics(),
//       children: [
//         _buildDashboardCard("Total Categories", "100", Icons.category, Colors.orange),
//         _buildDashboardCard("Orders Pending", "50", Icons.pending, Colors.red),
//         _buildDashboardCard("Orders Shipped", "80", Icons.local_shipping, Colors.blue),
//         _buildDashboardCard("Orders Delivered", "120", Icons.check_circle, Colors.green),
//       ],
//     );
//   }

//   // 📌 Beautiful Dashboard Card
//   Widget _buildDashboardCard(String title, String value, IconData icon, Color color) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 5,
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: color),
//             SizedBox(height: 10),
//             Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             SizedBox(height: 5),
//             Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color)),
//           ],
//         ),
//       ),
//     );
//   }

//   // 📌 Chart Card
//   Widget _buildChartCard() {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Orders Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Container(
//               height: 200,
//               child: BarChart(
//                 BarChartData(
//                   barGroups: [
//                     _buildBarChartData(0, 100, Colors.orange),
//                     _buildBarChartData(1, 50, Colors.red),
//                     _buildBarChartData(2, 80, Colors.blue),
//                     _buildBarChartData(3, 120, Colors.green),
//                   ],
//                   borderData: FlBorderData(show: false),
//                   titlesData: FlTitlesData(show: false),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 📌 Bar Chart Data
//   BarChartGroupData _buildBarChartData(int x, double y, Color color) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [BarChartRodData(toY: y, color: color, width: 20)],
//     );
//   }
// }
