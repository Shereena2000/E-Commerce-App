import 'package:fashion_admin_app/views/analytics/screens/order_status_screen.dart';
import 'package:fashion_admin_app/views/analytics/screens/sales_analytics_screen.dart';
import 'package:fashion_admin_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';


class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedFilter = 'weekly';
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Analytics'),
      body: Column(
        children: [
       
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 0, label: Text('Order Status')),
                ButtonSegment(value: 1, label: Text('Sales Analytics')),
              ],
              selected: {_currentPage},
              onSelectionChanged: (Set<int> newValue) {
                setState(() {
                  _currentPage = newValue.first;
                });
              },
            ),
          ),
        
          Expanded(
            child: _currentPage == 0
                ? buildOrderStatus()
                :const SalesAnalyticsScreen()
              
          ),
        ],
      ),
    );
  }

}