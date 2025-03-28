import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InvestmentAcquiredScreen extends StatefulWidget {
  const InvestmentAcquiredScreen({super.key});

  @override
  State<InvestmentAcquiredScreen> createState() =>
      _InvestmentAcquiredScreenState();
}

class _InvestmentAcquiredScreenState extends State<InvestmentAcquiredScreen> {
  final List<Map<String, dynamic>> investors = [
    {"name": "John Doe", "amount": 50000, "date": "2025-03-18"},
    {"name": "Jane Smith", "amount": 75000, "date": "2025-03-19"},
    {"name": "Elon Rich", "amount": 25000, "date": "2025-03-20"},
  ];

  final double totalTarget = 200000;

  @override
  Widget build(BuildContext context) {
    double totalRaised = investors.fold(
        0.0, (sum, investor) => sum + (investor['amount'] as int).toDouble());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Funding Progress"),
              const SizedBox(height: 8),
              _progressSection(totalRaised, totalTarget),
              const SizedBox(height: 30),
              _sectionTitle("Investment Distribution"),
              SizedBox(height: 220, child: _InvestmentPieChart(investors)),
              const SizedBox(height: 30),
              _sectionTitle("Investor Details"),
              ...investors.map((investor) => _investorTile(investor)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
    );
  }

  Widget _progressSection(double raised, double target) {
    double percent = (raised / target).clamp(0, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Raised: \$${raised.toStringAsFixed(0)} / \$${target.toStringAsFixed(0)}"),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percent,
          color: const Color(0xFF0AD98D),
          backgroundColor: Colors.grey[300],
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }

  Widget _investorTile(Map<String, dynamic> investor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 32, 172, 130),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(investor['name']),
        subtitle:
            Text("Invested \$${investor['amount']} on ${investor['date']}"),
        trailing: const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}

class _InvestmentPieChart extends StatelessWidget {
  final List<Map<String, dynamic>> investors;
  const _InvestmentPieChart(this.investors);

  @override
  Widget build(BuildContext context) {
    double total = investors.fold(
        0.0, (sum, investor) => sum + (investor['amount'] as int).toDouble());

    return PieChart(
      PieChartData(
        sections: investors.map((investor) {
          final percentage =
              ((investor['amount'] as int).toDouble() / total) * 100;
          return PieChartSectionData(
            value: investor['amount'].toDouble(),
            color: _getColor(investors.indexOf(investor)),
            title:
                '${investor['name'].split(" ")[0]} (${percentage.toStringAsFixed(1)}%)',
            radius: 50,
            titleStyle: const TextStyle(fontSize: 11, color: Colors.white),
          );
        }).toList(),
        sectionsSpace: 4,
        centerSpaceRadius: 30,
      ),
    );
  }

  Color _getColor(int index) {
    const colors = [
      Color(0xFF0AD98D),
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.red
    ];
    return colors[index % colors.length];
  }
}
