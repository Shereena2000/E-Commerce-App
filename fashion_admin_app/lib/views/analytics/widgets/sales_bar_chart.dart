import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesBarChart extends StatelessWidget {
  final List<double> salesData;
  final String filter;
  final int selectedYear;
  final int selectedMonth;

  const SalesBarChart({
    required this.salesData,
    required this.filter,
    required this.selectedYear,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Y-axis Label
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Total Sales (${_getCurrencySymbol()})', 
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
     const   SizedBox(height: 8),
        // Chart
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: _buildBarGroups(),
              titlesData: _buildTitlesData(),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(enabled: true,), 
              
            ),
          ),
        ),
      ],
    );
  }

  String _getCurrencySymbol() {

    return '₹';
  }

  List<BarChartGroupData> _buildBarGroups() {
    return salesData.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: colorTheme,
            width: 20, 
          ),
        ],
      );
    }).toList();
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      // Bottom X-axis titles
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            if (filter == 'weekly') {
              return Text('Week ${value.toInt() + 1}');
            } else if (filter == 'monthly') {
              return Transform.rotate( angle: -45 * (3.141592653589793 / 180),child: Text(_getMonthName(value.toInt() + 1)));
            } else if (filter == 'yearly') {
              return Text('${selectedYear - (salesData.length - value.toInt() - 1)}');
            }
            return Text('');
          },
        ),
      ),
      // Left Y-axis titles
      leftTitles: AxisTitles(
  sideTitles: SideTitles(
    showTitles: true,
    reservedSize: 40, // Increase space for labels
    getTitlesWidget: (value, meta) {
      return Text(_formatYAxisValue(value),
          style: TextStyle(fontSize: 12)); // Adjust font size if needed
    },
  ),
),

      // Hide top X-axis titles
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      // Hide right Y-axis titles
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

String _formatYAxisValue(double value) {
  if (value >= 1000000) {
    return '${(value ~/ 1000000)}M'; // Convert to millions without decimals
  } else if (value >= 1000) {
    return '${(value ~/ 1000)}K'; // Convert to thousands without decimals
  } else {
    return '${value.toInt()}'; // Show as-is for small numbers
  }
}


  String _getMonthName(int month) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1];
  }
}