import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic>? companyData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('companies').doc(uid).get();

    if (doc.exists) {
      setState(() {
        companyData = doc.data() as Map<String, dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (companyData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    List<double> revenues = [
      double.tryParse(companyData!['lllllyearrevenue'] ?? '0') ?? 0,
      double.tryParse(companyData!['llllyearrevenue'] ?? '0') ?? 0,
      double.tryParse(companyData!['lllyearrevenue'] ?? '0') ?? 0,
      double.tryParse(companyData!['llyearrevenue'] ?? '0') ?? 0,
      double.tryParse(companyData!['lyearrevenue'] ?? '0') ?? 0,
    ];

    List<String> years = ["2020", "2021", "2022", "2023", "2024"];

    double maxRevenue = revenues.reduce((a, b) => a > b ? a : b);
    if (maxRevenue == 0) maxRevenue = 100; // fallback for empty data

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Revenue Growth Over Last 5 Years",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 400,
                height: 400,
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: maxRevenue + (maxRevenue * 0.3),
                    alignment: BarChartAlignment.spaceAround,
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 && index < years.length) {
                              return Text(years[index],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12));
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text("${value.toInt()}",
                                style: const TextStyle(fontSize: 10));
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(5, (index) {
                      return BarChartGroupData(x: index, barRods: [
                        BarChartRodData(
                          toY: revenues[index],
                          width: 18,
                          color: const Color.fromARGB(255, 32, 172, 130),
                          borderRadius: BorderRadius.circular(4),
                          // Display values above bars
                          rodStackItems: [],
                        )
                      ], showingTooltipIndicators: [
                        0
                      ]);
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Manual labels on top of each bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: revenues
                  .map((e) => Text(
                        '${e.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
