import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OrderStatusPieChart extends StatefulWidget {
  final int delivered;
  final int cancelled;
  final int shipped;
  final int pending;

  OrderStatusPieChart({
    required this.delivered,
    required this.cancelled,
    required this.shipped,
    required this.pending,
  });

  @override
  _OrderStatusPieChartState createState() => _OrderStatusPieChartState();
}
class _OrderStatusPieChartState extends State<OrderStatusPieChart> {
  int? touchedIndex;
    
  @override
  Widget build(BuildContext context) {
    int total = widget.delivered + widget.cancelled + widget.shipped + widget.pending;
    
    return Column(
      children: [
        // Pie chart with adjusted height for mobile
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: PieChart(
            PieChartData(
              sections: _generateSections(total),
              centerSpaceRadius: 40,
              sectionsSpace: 2,
              borderData: FlBorderData(show: false),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, PieTouchResponse? response) {
                  setState(() {
                    if (event is FlTapUpEvent) {
                      touchedIndex = response?.touchedSection?.touchedSectionIndex;
                    }
                  });
                },
              ),
            ),
          ),
        ),
        moderateSpacing,
        // Legend that scrolls if needed on smaller screens
        buildLegend(total),
      ],
    );
  }

  List<PieChartSectionData> _generateSections(int total) {
    return [
      _buildSection(0, widget.delivered, 'Delivered', const Color.fromRGBO(108, 73, 47, 1), total),
      _buildSection(1, widget.cancelled, 'Cancelled', const Color.fromRGBO(185, 157, 132, 1), total),
      _buildSection(2, widget.shipped, 'Shipped', const Color.fromRGBO(152, 120, 97, 1), total),
      _buildSection(3, widget.pending, 'Pending', const Color.fromRGBO(125, 92, 69, 1), total),
    ];
  }

  PieChartSectionData _buildSection(int index, int value, String title, Color color, int total) {
    final isSelected = touchedIndex == index;
    
    final percentage = total > 0 ? (value / total * 100).toStringAsFixed(1) : '0.0';
    
    return PieChartSectionData(
      value: value.toDouble(),
      title: isSelected ? '$percentage%' : '',
      color: color,
      radius: isSelected ? 75 : 60,
      titleStyle: TextStyle(
        fontSize: isSelected ? 14 : 12,
        fontWeight: FontWeight.bold,
        color: isSelected ? Colors.black : Colors.white,
      ),
    );
  }

  Widget buildLegend(int total) {
    // Using a simpler approach for mobile - vertical list that guarantees all items are shown
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 16.0, // space between items horizontally
        runSpacing: 8.0, // space between rows
        alignment: WrapAlignment.center,
        children: [
          _buildLegendItem('Delivered', widget.delivered, const Color.fromRGBO(108, 73, 47, 1), total),
          _buildLegendItem('Cancelled', widget.cancelled, const Color.fromRGBO(185, 157, 132, 1), total),
          _buildLegendItem('Shipped', widget.shipped, const Color.fromRGBO(152, 120, 97, 1), total),
          _buildLegendItem('Pending', widget.pending, const Color.fromRGBO(125, 92, 69, 1), total),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, int value, Color color, int total) {
    final percentage = total > 0 ? (value / total * 100).toStringAsFixed(1) : '0.0';
    // Fixed width container that works better on mobile
    return Container(
      width: 150, // Fixed width that should fit on most phones
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 16, height: 16, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '$title: $value ($percentage%)',
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
