 import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fashion_admin_app/models/order_model.dart';
import 'package:fashion_admin_app/providers/admin_providers.dart';

import 'package:fashion_admin_app/views/analytics/widgets/sales_bar_chart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesAnalyticsScreen extends StatefulWidget {
  const SalesAnalyticsScreen({super.key});

  @override
  _SalesAnalyticsScreenState createState() => _SalesAnalyticsScreenState();
}

class _SalesAnalyticsScreenState extends State<SalesAnalyticsScreen> {
  String selectedFilter = 'weekly';
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProviders>(
      builder: (context, adminProvider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SegmentedButton<String>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 'weekly', label: Text('Weekly')),
                      ButtonSegment(value: 'monthly', label: Text('Monthly')),
                      ButtonSegment(value: 'yearly', label: Text('Yearly')),
                    ],
                    selected: {selectedFilter},
                    onSelectionChanged: (Set<String> newValue) {
                      setState(() {
                        selectedFilter = newValue.first;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedFilter != 'yearly') _buildDateFilters(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SalesBarChart(
                  salesData: _getFilteredSalesData(adminProvider.orders),
                  filter: selectedFilter,
                  selectedYear: selectedYear,
                  selectedMonth: selectedMonth,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateFilters() {
    if (selectedFilter == 'weekly') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<int>(
            value: selectedMonth,
            items: List.generate(12, (index) {
              return DropdownMenuItem(
                value: index + 1,
                child: Text(_getMonthName(index + 1)),
              );
            }),
            onChanged: (value) {
              setState(() {
                selectedMonth = value!;
              });
            },
          ),
          const SizedBox(width: 16),
          DropdownButton<int>(
            value: selectedYear,
            items: _getAvailableYears().map((year) {
              return DropdownMenuItem(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedYear = value!;
              });
            },
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<int>(
            value: selectedYear,
            items: _getAvailableYears().map((year) {
              return DropdownMenuItem(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedYear = value!;
              });
            },
          ),
        ],
      );
    }
  }

  List<int> _getAvailableYears() {
    Set<int> years = {DateTime.now().year}; // Include current year by default
    return years.toList()..sort();
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  List<double> _getFilteredSalesData(List<QueryDocumentSnapshot> orders) {
    switch (selectedFilter) {
      case 'weekly':
        return _getWeeklySalesData(orders);
      case 'monthly':
        return _getMonthlySalesData(orders);
      case 'yearly':
        return _getYearlySalesData(orders);
      default:
        return List.filled(7, 0);
    }
  }

  List<double> _getWeeklySalesData(List<QueryDocumentSnapshot> orders) {
    List<double> salesData = List.filled(5, 0);
    for (var order in orders) {
      var orderModel = OrdersModel.fromJson(
        order.data() as Map<String, dynamic>,
        order.id,
      );
      var orderDate = DateTime.fromMillisecondsSinceEpoch(orderModel.created_at);
      if (orderDate.year == selectedYear && orderDate.month == selectedMonth) {
        int weekNumber = ((orderDate.day - 1) / 7).floor();
        if (weekNumber < 5) {
          salesData[weekNumber] += orderModel.total.toDouble();
        }
      }
    }
    return salesData;
  }

  List<double> _getMonthlySalesData(List<QueryDocumentSnapshot> orders) {
    List<double> salesData = List.filled(12, 0);
    for (var order in orders) {
      var orderModel = OrdersModel.fromJson(
        order.data() as Map<String, dynamic>,
        order.id,
      );
      var orderDate = DateTime.fromMillisecondsSinceEpoch(orderModel.created_at);
      if (orderDate.year == selectedYear) {
        salesData[orderDate.month - 1] += orderModel.total.toDouble();
      }
    }
    return salesData;
  }

  List<double> _getYearlySalesData(List<QueryDocumentSnapshot> orders) {
    var years = _getAvailableYears();
    List<double> salesData = List.filled(years.length, 0);
    for (var order in orders) {
      var orderModel = OrdersModel.fromJson(
        order.data() as Map<String, dynamic>,
        order.id,
      );
      var orderDate = DateTime.fromMillisecondsSinceEpoch(orderModel.created_at);
      var yearIndex = years.indexOf(orderDate.year);
      if (yearIndex != -1) {
        salesData[yearIndex] += orderModel.total.toDouble();
      }
    }
    return salesData;
  }
}
