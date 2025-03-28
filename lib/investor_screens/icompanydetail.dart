// import 'dart:math';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:ui/payment/services/stripe_service.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class CompanyDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> data;

//   const CompanyDetailScreen({super.key, required this.data});

//   @override
//   State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
// }

// class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
//   double? _predictedValue;

//   void _generateRandomPrediction() {
//     final random = Random();
//     // Generates a double between 4.0 and 10.0
//     double value = 4 + random.nextDouble() * 6;
//     setState(() {
//       _predictedValue = double.parse(value.toStringAsFixed(2));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = widget.data;
//     final videoUrl = data['pitchVideo'] ?? '';
//     final videoId = YoutubePlayer.convertUrlToId(videoUrl);

//     List<double> revenues = [
//       double.tryParse(data['lllllyearrevenue'] ?? '0') ?? 0,
//       double.tryParse(data['llllyearrevenue'] ?? '0') ?? 0,
//       double.tryParse(data['lllyearrevenue'] ?? '0') ?? 0,
//       double.tryParse(data['llyearrevenue'] ?? '0') ?? 0,
//       double.tryParse(data['lyearrevenue'] ?? '0') ?? 0,
//     ];

//     double maxRevenue = revenues.reduce((a, b) => a > b ? a : b);
//     if (maxRevenue == 0) maxRevenue = 100;

//     List<String> years = ["2020", "2021", "2022", "2023", "2024"];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(data['companyName'] ?? "Company Details"),
//         backgroundColor: const Color.fromARGB(255, 32, 172, 130),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage(data['logoUrl'] ?? ''),
//               backgroundColor: Colors.grey[300],
//             ),
//             const SizedBox(height: 16),
//             if (videoId != null)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: YoutubePlayer(
//                   width: double.infinity,
//                   controller: YoutubePlayerController(
//                     initialVideoId: videoId,
//                     flags: const YoutubePlayerFlags(autoPlay: false),
//                   ),
//                   showVideoProgressIndicator: true,
//                 ),
//               ),
//             const SizedBox(height: 20),
//             _buildDetailRow('Tagline', data['companyTagline']),
//             _buildDetailRow('Website', data['companywebsite']),
//             _buildDetailRow('Industry', data['industry']),
//             _buildDetailRow('Vision', data['vision']),
//             _buildDetailRow('Investment Ask', data['investmentAsk']),
//             _buildDetailRow('Equity Offered', "${data['equityOffered']}%"),
//             _buildDetailRow('Funding Stage', data['fundingStage']),
//             _buildDetailRow('Total Funding Raised', data['totalFundingRaised']),
//             _buildDetailRow('Valuation', data['valuation']),
//             _buildDetailRow('Year Founded', data['yearFounded']),
//             _buildDetailRow('Employees', data['noOfEmployees']),
//             _buildDetailRow('Customer Base', data['customerBase']),
//             _buildDetailRow('Annual Revenue', data['annualRevenue']),
//             _buildDetailRow('Country', data['country']),
//             _buildDetailRow('Target Market', data['targetMarket']),
//             _buildDetailRow('Problem', data['problemStatement']),
//             _buildDetailRow('Solution', data['solution']),
//             _buildDetailRow('Milestones', data['milestones']),
//             _buildDetailRow('Contact', data['contactUs']),
//             _buildDetailRow('Prior Investors', data['priorInvestors']),
//             _buildDetailRow('Additional Notes', data['additionalNotes']),
//             const SizedBox(height: 30),
//             const Divider(),
//             const SizedBox(height: 10),
//             const Text(
//               "Revenue Trends (Last 5 Years)",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: 400,
//               height: 400,
//               child: BarChart(
//                 BarChartData(
//                   minY: 0,
//                   maxY: maxRevenue + (maxRevenue * 0.3),
//                   alignment: BarChartAlignment.spaceAround,
//                   barTouchData: BarTouchData(enabled: true),
//                   titlesData: FlTitlesData(
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           int index = value.toInt();
//                           if (index >= 0 && index < years.length) {
//                             return Text(years[index],
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 12));
//                           }
//                           return const Text('');
//                         },
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: (value, meta) {
//                           return Text("${value.toInt()}",
//                               style: const TextStyle(fontSize: 10));
//                         },
//                       ),
//                     ),
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                   ),
//                   gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: false,
//                   ),
//                   borderData: FlBorderData(show: false),
//                   barGroups: List.generate(5, (index) {
//                     return BarChartGroupData(x: index, barRods: [
//                       BarChartRodData(
//                         toY: revenues[index],
//                         width: 18,
//                         color: const Color.fromARGB(255, 32, 172, 130),
//                         borderRadius: BorderRadius.circular(4),
//                       )
//                     ], showingTooltipIndicators: [
//                       0
//                     ]);
//                   }),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 MaterialButton(
//                   onPressed: () {
//                     StripeService.instance.makePayment(
//                       context: context,
//                       companyData: data,
//                     );
//                   },
//                   color: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   child: const Text(
//                     "Invest",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 MaterialButton(
//                   onPressed: _generateRandomPrediction,
//                   color: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                   child: const Text(
//                     "Predict Success",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             if (_predictedValue != null)
//               Text(
//                 "Predicted Success Score: $_predictedValue / 10",
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple),
//               ),
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String title, dynamic value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade300,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             )
//           ],
//         ),
//         child: ListTile(
//           title: Text(
//             title,
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           subtitle: Text(
//             value ?? 'N/A',
//             style: const TextStyle(color: Colors.black54),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ui/payment/services/stripe_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CompanyDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const CompanyDetailScreen({super.key, required this.data});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  double? _predictedValue;

  void _generateRandomPrediction() {
    final random = Random();
    double value = 4 + random.nextDouble() * 6;
    setState(() {
      _predictedValue = double.parse(value.toStringAsFixed(2));
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final videoUrl = data['pitchVideo'] ?? '';
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    List<double> revenues = [
      double.tryParse(data['lllllyearrevenue'] ?? '0') ?? 0,
      double.tryParse(data['llllyearrevenue'] ?? '0') ?? 0,
      double.tryParse(data['lllyearrevenue'] ?? '0') ?? 0,
      double.tryParse(data['llyearrevenue'] ?? '0') ?? 0,
      double.tryParse(data['lyearrevenue'] ?? '0') ?? 0,
    ];

    double maxRevenue = revenues.reduce((a, b) => a > b ? a : b);
    if (maxRevenue == 0) maxRevenue = 100;

    List<String> years = ["2020", "2021", "2022", "2023", "2024"];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          data['companyName'] ?? "Company Details",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: const Color(0xFF20AC82),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/logo.jpg'),
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['companyTagline'] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(data['vision'] ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Pitch Video Section
            if (videoId != null)
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: YoutubePlayer(
                    width: double.infinity,
                    controller: YoutubePlayerController(
                      initialVideoId: videoId,
                      flags: const YoutubePlayerFlags(autoPlay: false),
                    ),
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Info Sections
            _sectionTitle("Company Details"),
            _buildDetail("Website", data['companywebsite']),
            _buildDetail("Industry", data['industry']),
            _buildDetail("Funding Stage", data['fundingStage']),
            _buildDetail("Investment Ask", "\$${data['investmentAsk']}"),
            _buildDetail("Equity Offered", "${data['equityOffered']}%"),
            _buildDetail(
                "Total Funding Raised", "\$${data['totalFundingRaised']}"),
            _buildDetail("Valuation", "\$${data['valuation']}"),
            _buildDetail("Year Founded", data['yearFounded']),
            _buildDetail("Employees", data['noOfEmployees']),
            _buildDetail("Country", data['country']),
            _buildDetail("Customer Base", data['customerBase']),

            const SizedBox(height: 16),
            _sectionTitle("Business Overview"),
            _buildDetail("Target Market", data['targetMarket']),
            _buildDetail("Problem", data['problemStatement']),
            _buildDetail("Solution", data['solution']),
            _buildDetail("Milestones", data['milestones']),
            _buildDetail("Prior Investors", data['priorInvestors']),
            _buildDetail("Additional Notes", data['additionalNotes']),
            _buildDetail("Contact", data['contactUs']),

            const SizedBox(height: 25),

            // Graph Section
            _sectionTitle("Revenue Trends (Last 5 Years)"),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
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
                                return Text(
                                  years[index],
                                  style: const TextStyle(fontSize: 11),
                                );
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
                              return Text(
                                "${value.toInt()}",
                                style: const TextStyle(fontSize: 10),
                              );
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
                      gridData: FlGridData(show: true, drawVerticalLine: false),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(5, (index) {
                        return BarChartGroupData(x: index, barRods: [
                          BarChartRodData(
                            toY: revenues[index],
                            width: 16,
                            color: const Color(0xFF20AC82),
                            borderRadius: BorderRadius.circular(4),
                          )
                        ], showingTooltipIndicators: [
                          0
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    StripeService.instance.makePayment(
                      context: context,
                      companyData: data,
                    );
                  },
                  icon: const Icon(Icons.attach_money),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  label: const Text(
                    "Invest",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _generateRandomPrediction,
                  icon: const Icon(Icons.assessment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  label: const Text(
                    "Predict Success",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_predictedValue != null)
              Text(
                "Predicted Success Score: $_predictedValue / 10",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildDetail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3))
          ],
        ),
        child: ListTile(
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(value ?? 'N/A'),
        ),
      ),
    );
  }
}
