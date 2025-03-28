// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:ui/investor_screens/icompanydetail.dart';
// import 'package:ui/investor_screens/imakeprofilescreen.dart';

// class InvestorHomeScreen extends StatefulWidget {
//   const InvestorHomeScreen({super.key});

//   @override
//   State<InvestorHomeScreen> createState() => _InvestorHomeScreenState();
// }

// class _InvestorHomeScreenState extends State<InvestorHomeScreen> {
//   final uid = FirebaseAuth.instance.currentUser!.uid;
//   bool hasProfile = false;
//   String? investorName;

//   @override
//   void initState() {
//     super.initState();
//     checkInvestorProfile();
//   }

//   void checkInvestorProfile() async {
//     DocumentSnapshot doc =
//         await FirebaseFirestore.instance.collection('investors').doc(uid).get();

//     if (doc.exists) {
//       setState(() {
//         hasProfile = true;
//         investorName = doc['name'];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: hasProfile ? _buildInvestorDashboard() : _buildProfilePrompt(),
//     );
//   }

//   Widget _buildProfilePrompt() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.account_circle, size: 80, color: Colors.grey),
//           const SizedBox(height: 16),
//           const Text(
//             "You need to complete your investor profile to proceed.",
//             style: TextStyle(fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => InvestorProfileScreen()),
//               ).then((_) => checkInvestorProfile());
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromARGB(255, 32, 172, 130),
//             ),
//             child: const Text("Create Profile"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInvestorDashboard() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         Text(
//           "👋 Hello, ${investorName ?? "Investor"}!",
//           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           "Discover Companies to Invest",
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
//         ),
//         const SizedBox(height: 20),
//         _buildCompanyList(),
//       ],
//     );
//   }

//   Widget _buildCompanyList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('companies').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final docs = snapshot.data!.docs;

//         if (docs.isEmpty) {
//           return const Center(child: Text('No companies listed yet.'));
//         }

//         return Column(
//           children: docs.map((doc) {
//             var data = doc.data() as Map<String, dynamic>;

//             return Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey.shade300),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   )
//                 ],
//               ),
//               child: ListTile(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => CompanyDetailScreen(data: data),
//                     ),
//                   );
//                 },
//                 title: Text(
//                   data['companyName'] ?? 'Unnamed Company',
//                   style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 5),
//                     Text("Industry: ${data['industry'] ?? 'N/A'}",
//                         style: const TextStyle(color: Colors.black87)),
//                     Text("Equity Offered: ${data['equityOffered'] ?? 'N/A'}%",
//                         style: const TextStyle(color: Colors.black87)),
//                     Text("Investment Ask: ${data['investmentAsk'] ?? 'N/A'}",
//                         style: const TextStyle(color: Colors.black87)),
//                   ],
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios,
//                     color: Colors.black87, size: 18),
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// // 1. Investor Home Screen
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'icompanydetail.dart';
// // import 'imakeprofilescreen.dart';

// // class InvestorHomeScreen extends StatefulWidget {
// //   const InvestorHomeScreen({super.key});

// //   @override
// //   State<InvestorHomeScreen> createState() => _InvestorHomeScreenState();
// // }

// // class _InvestorHomeScreenState extends State<InvestorHomeScreen> {
// //   final uid = FirebaseAuth.instance.currentUser!.uid;
// //   bool hasProfile = false;
// //   String? investorName;

// //   @override
// //   void initState() {
// //     super.initState();
// //     checkInvestorProfile();
// //   }

// //   void checkInvestorProfile() async {
// //     DocumentSnapshot doc =
// //         await FirebaseFirestore.instance.collection('investors').doc(uid).get();

// //     if (doc.exists) {
// //       setState(() {
// //         hasProfile = true;
// //         investorName = doc['name'];
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: hasProfile ? _buildInvestorDashboard() : _buildProfilePrompt(),
// //     );
// //   }

// //   Widget _buildProfilePrompt() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const Icon(Icons.account_circle, size: 80, color: Colors.grey),
// //           const SizedBox(height: 16),
// //           const Text(
// //             "You need to complete your investor profile to proceed.",
// //             style: TextStyle(fontSize: 18),
// //             textAlign: TextAlign.center,
// //           ),
// //           const SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => InvestorProfileScreen()),
// //               ).then((_) => checkInvestorProfile());
// //             },
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: const Color.fromARGB(255, 32, 172, 130),
// //             ),
// //             child: const Text("Create Profile"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildInvestorDashboard() {
// //     return ListView(
// //       padding: const EdgeInsets.all(16),
// //       children: [
// //         Text(
// //           "\u{1F44B} Hello, ${investorName ?? "Investor"}!",
// //           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //         ),
// //         const SizedBox(height: 10),
// //         const Text(
// //           "Discover Companies to Invest",
// //           style: TextStyle(
// //               fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
// //         ),
// //         const SizedBox(height: 20),
// //         _buildCompanyList(),
// //       ],
// //     );
// //   }

// //   Widget _buildCompanyList() {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection('companies').snapshots(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         final docs = snapshot.data!.docs;

// //         if (docs.isEmpty) {
// //           return const Center(child: Text('No companies listed yet.'));
// //         }

// //         return Column(
// //           children: docs.map((doc) {
// //             var data = doc.data() as Map<String, dynamic>;

// //             return Container(
// //               margin: const EdgeInsets.only(bottom: 15),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(15),
// //                 color: Colors.white,
// //                 border: Border.all(color: Colors.grey.shade300),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.1),
// //                     blurRadius: 5,
// //                     offset: const Offset(0, 3),
// //                   )
// //                 ],
// //               ),
// //               child: ListTile(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => CompanyDetailScreen(data: data),
// //                     ),
// //                   );
// //                 },
// //                 title: Text(
// //                   data['companyName'] ?? 'Unnamed Company',
// //                   style: const TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.black),
// //                 ),
// //                 subtitle: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const SizedBox(height: 5),
// //                     Text("Industry: ${data['industry'] ?? 'N/A'}",
// //                         style: const TextStyle(color: Colors.black87)),
// //                     Text("Equity Offered: ${data['equityOffered'] ?? 'N/A'}%",
// //                         style: const TextStyle(color: Colors.black87)),
// //                     Text("Investment Ask: ${data['investmentAsk'] ?? 'N/A'}",
// //                         style: const TextStyle(color: Colors.black87)),
// //                   ],
// //                 ),
// //                 trailing: const Icon(Icons.arrow_forward_ios,
// //                     color: Colors.black87, size: 18),
// //               ),
// //             );
// //           }).toList(),
// //         );
// //       },
// //     );
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui/investor_screens/icompanydetail.dart';
import 'package:ui/investor_screens/imakeprofilescreen.dart';

class InvestorHomeScreen extends StatefulWidget {
  const InvestorHomeScreen({super.key});

  @override
  State<InvestorHomeScreen> createState() => _InvestorHomeScreenState();
}

class _InvestorHomeScreenState extends State<InvestorHomeScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool hasProfile = false;
  String? investorName;

  @override
  void initState() {
    super.initState();
    checkInvestorProfile();
  }

  void checkInvestorProfile() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('investors').doc(uid).get();

    if (doc.exists) {
      setState(() {
        hasProfile = true;
        investorName = doc['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: hasProfile ? _buildInvestorDashboard() : _buildProfilePrompt(),
    );
  }

  Widget _buildProfilePrompt() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "You need to complete your investor profile to proceed.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const InvestorProfileScreen()),
                ).then((_) => checkInvestorProfile());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF20AC82),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
              label: const Text(
                "Create Profile",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestorDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "👋 Hello, ${investorName ?? "Investor"}!",
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 8),
          const Text(
            "Explore startups seeking investment 👇",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _buildCompanyList(),
        ],
      ),
    );
  }

  Widget _buildCompanyList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('companies').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(child: Text('No companies listed yet.'));
        }

        return Column(
          children: docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CompanyDetailScreen(data: data),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF20AC82),
                  child: const Icon(Icons.business_center, color: Colors.white),
                ),
                title: Text(
                  data['companyName'] ?? 'Unnamed Company',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text("Industry: ${data['industry'] ?? 'N/A'}",
                        style: const TextStyle(color: Colors.black87)),
                    Text("Equity Offered: ${data['equityOffered'] ?? 'N/A'}%",
                        style: const TextStyle(color: Colors.black87)),
                    Text("Investment Ask: \$${data['investmentAsk'] ?? 'N/A'}",
                        style: const TextStyle(color: Colors.black87)),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.grey, size: 18),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
