import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InvestorStatisticsScreen extends StatefulWidget {
  const InvestorStatisticsScreen({super.key});

  @override
  State<InvestorStatisticsScreen> createState() =>
      _InvestorStatisticsScreenState();
}

class _InvestorStatisticsScreenState extends State<InvestorStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildKpiSection(),
              const SizedBox(height: 25),
              const Text(
                "Portfolio Allocation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildPieChart(),
              const SizedBox(height: 30),
              const Text(
                "Investment Trends (6 months)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildBarChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKpiSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _kpiCard("Total Invested", "\$155,00"),
        _kpiCard("Companies", "12"),
        _kpiCard("Avg ROI", "14%"),
      ],
    );
  }

  Widget _kpiCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF20AC82))),
            const SizedBox(height: 4),
            Text(title,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 40,
              color: const Color(0xFF20AC82),
              title: 'Logistics\n40%',
              radius: 55,
              titleStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            PieChartSectionData(
              value: 30,
              color: Colors.blue,
              title: 'Tech\n30%',
              radius: 50,
              titleStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            PieChartSectionData(
              value: 20,
              color: Colors.orange,
              title: 'Health\n20%',
              radius: 45,
              titleStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            PieChartSectionData(
              value: 10,
              color: Colors.purple,
              title: 'AI\n10%',
              radius: 40,
              titleStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
          sectionsSpace: 4,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    List<double> data = [20, 35, 50, 30, 60, 80];

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
            )),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const months = ["Sep", "Oct", "Nov", "Dec", "Jan", "Feb"];
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(months[value.toInt()],
                        style: const TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: data.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value,
                  color: const Color(0xFF20AC82),
                  width: 14,
                  borderRadius: BorderRadius.circular(4),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
