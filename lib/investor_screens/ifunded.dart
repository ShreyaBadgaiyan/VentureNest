// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MyInvestmentsScreen extends StatelessWidget {
//   const MyInvestmentsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final uid = FirebaseAuth.instance.currentUser!.uid;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Investments"),
//         backgroundColor: const Color.fromARGB(255, 32, 172, 130),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('investors')
//             .doc(uid)
//             .collection('investments')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final docs = snapshot.data!.docs;

//           if (docs.isEmpty) {
//             return const Center(child: Text("No investments yet."));
//           }

//           return ListView(
//             padding: const EdgeInsets.all(16),
//             children: docs.map((doc) {
//               final data = doc.data() as Map<String, dynamic>;

//               return Container(
//                 margin: const EdgeInsets.only(bottom: 15),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade300),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     )
//                   ],
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     data['companyName'] ?? 'Company',
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 5),
//                       Text("Industry: ${data['industry'] ?? 'N/A'}",
//                           style: const TextStyle(color: Colors.black87)),
//                       Text("Equity: ${data['equityOffered']}%",
//                           style: const TextStyle(color: Colors.black87)),
//                       Text("Invested: \$${data['investmentAsk']}",
//                           style: const TextStyle(color: Colors.black87)),
//                       if (data['timestamp'] != null)
//                         Text(
//                           "Date: ${(data['timestamp'] as Timestamp).toDate()}",
//                           style: const TextStyle(color: Colors.black87),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class InvestmentDoneScreen extends StatefulWidget {
  const InvestmentDoneScreen({super.key});

  @override
  State<InvestmentDoneScreen> createState() => _InvestmentDoneScreenState();
}

class _InvestmentDoneScreenState extends State<InvestmentDoneScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> investments = [
      {
        "company": "Alpha Tech",
        "industry": "AI",
        "amount": "\$50,000",
        "date": "2025-01-15"
      },
      {
        "company": "HealthPro",
        "industry": "Healthcare",
        "amount": "\$75,000",
        "date": "2025-02-20"
      },
      {
        "company": "FinEdge",
        "industry": "FinTech",
        "amount": "\$30,000",
        "date": "2025-03-01"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (var investment in investments)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF20AC82),
                    child: Icon(Icons.business, color: Colors.white),
                  ),
                  title: Text(
                    investment['company'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle:
                      Text("${investment['industry']} • ${investment['date']}"),
                  trailing: Text(
                    investment['amount'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 14),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
