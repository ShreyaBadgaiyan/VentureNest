// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:core/entrepreneur_screens/register.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EnHomeScreen extends StatefulWidget {
//   const EnHomeScreen({super.key});

//   @override
//   State<EnHomeScreen> createState() => _EnHomeScreenState();
// }

// class _EnHomeScreenState extends State<EnHomeScreen> {
//   bool isRegistered = false;
//   String? companyName;
//   final uid = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   void initState() {
//     super.initState();
//     checkCompanyRegistration();
//   }

//   void checkCompanyRegistration() async {
//     DocumentSnapshot doc =
//         await FirebaseFirestore.instance.collection('companies').doc(uid).get();

//     if (doc.exists) {
//       setState(() {
//         isRegistered = true;
//         companyName = doc['companyName'];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: isRegistered
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "👋 Good Morning, ${companyName ?? 'Entrepreneur'}!",
//                     style: const TextStyle(fontSize: 22),
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     "Welcome to your dashboard 🚀",
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                 ],
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Oops! It looks like your company is not registered yet.",
//                     style: TextStyle(fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => CompanyFormScreen()),
//                       );
//                     },
//                     child: const Text('Register Your Company'),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:core/entrepreneur_screens/register.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EnHomeScreen extends StatefulWidget {
//   const EnHomeScreen({super.key});

//   @override
//   State<EnHomeScreen> createState() => _EnHomeScreenState();
// }

// class _EnHomeScreenState extends State<EnHomeScreen> {
//   bool isRegistered = false;
//   String? companyName;
//   final uid = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   void initState() {
//     super.initState();
//     checkCompanyRegistration();
//   }

//   void checkCompanyRegistration() async {
//     DocumentSnapshot doc =
//         await FirebaseFirestore.instance.collection('companies').doc(uid).get();

//     if (doc.exists) {
//       setState(() {
//         isRegistered = true;
//         companyName = doc['companyName'];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: isRegistered
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "👋 Good Morning, ${companyName ?? 'Entrepreneur'}!",
//                     style: const TextStyle(fontSize: 22),
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     "Welcome to your dashboard 🚀",
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                 ],
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Oops! It looks like your company is not registered yet.",
//                     style: TextStyle(fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // Navigate & wait for result
//                       await Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => CompanyFormScreen()),
//                       );
//                       // Check registration again after returning
//                       checkCompanyRegistration();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 32, 172, 130),
//                     ),
//                     child: const Text('Register Your Company'),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ui/entrepreneur_screens/register.dart';

// class EnHomeScreen extends StatefulWidget {
//   const EnHomeScreen({super.key});

//   @override
//   State<EnHomeScreen> createState() => _EnHomeScreenState();
// }

// class _EnHomeScreenState extends State<EnHomeScreen> {
//   bool isRegistered = false;
//   String? companyName;
//   final uid = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   void initState() {
//     super.initState();
//     checkCompanyRegistration();
//   }

//   void checkCompanyRegistration() async {
//     DocumentSnapshot doc =
//         await FirebaseFirestore.instance.collection('companies').doc(uid).get();

//     if (doc.exists) {
//       setState(() {
//         isRegistered = true;
//         companyName = doc['companyName'];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: isRegistered
//             ? SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Greeting
//                     Text(
//                       "👋 Good Morning, ${companyName ?? 'Entrepreneur'}!",
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       "Welcome to your dashboard 🚀",
//                       style: TextStyle(color: Colors.grey, fontSize: 16),
//                     ),
//                     const SizedBox(height: 25),

//                     // Funding card
//                     _dashboardCard(
//                       title: "Funding Progress",
//                       content: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("You've raised 50% of your target."),
//                           const SizedBox(height: 8),
//                           LinearProgressIndicator(
//                             value: 0.5,
//                             backgroundColor: Colors.grey[300],
//                             color: const Color(0xFF0AD98D),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Quick actions
//                     const Text(
//                       "Quick Actions",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _quickAction(Icons.person, "Edit Profile"),
//                         _quickAction(Icons.stacked_line_chart, "Stats"),
//                         _quickAction(Icons.message, "Chats"),
//                         _quickAction(Icons.flag, "Milestones"),
//                       ],
//                     ),
//                     const SizedBox(height: 30),

//                     // Placeholder for recent updates
//                     const Text(
//                       "Recent Updates",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     const SizedBox(height: 10),
//                     _updateTile("You reached 50% of your funding goal! 🎯"),
//                     _updateTile("New investor message received 💬"),
//                   ],
//                 ),
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.business, size: 70, color: Colors.grey),
//                   const SizedBox(height: 16),
//                   const Text(
//                     "Oops! It looks like your company is not registered yet.",
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => CompanyFormScreen()),
//                       );
//                       checkCompanyRegistration();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 32, 172, 130),
//                     ),
//                     child: const Text(
//                       'Register Your Company',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   Widget _dashboardCard({required String title, required Widget content}) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey.shade300,
//               blurRadius: 5,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 10),
//           content,
//         ],
//       ),
//     );
//   }

//   Widget _quickAction(IconData icon, String label) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 24,
//           backgroundColor: const Color.fromARGB(255, 32, 172, 130),
//           child: Icon(icon, color: Colors.white),
//         ),
//         const SizedBox(height: 6),
//         Text(label, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }

//   Widget _updateTile(String text) {
//     return ListTile(
//       leading: const Icon(Icons.fiber_manual_record,
//           color: Color(0xFF0AD98D), size: 12),
//       title: Text(text),
//       dense: true,
//       contentPadding: EdgeInsets.zero,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/entrepreneur_screens/register.dart';

class EnHomeScreen extends StatefulWidget {
  const EnHomeScreen({super.key});

  @override
  State<EnHomeScreen> createState() => _EnHomeScreenState();
}

class _EnHomeScreenState extends State<EnHomeScreen> {
  bool isRegistered = false;
  String? companyName;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    checkCompanyRegistration();
  }

  void checkCompanyRegistration() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('companies').doc(uid).get();

    if (doc.exists) {
      setState(() {
        isRegistered = true;
        companyName = doc['companyName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isRegistered
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFF20AC82),
              onPressed: () {
                // Add navigation action here
              },
              label: const Text("Add Update"),
              icon: const Icon(Icons.add),
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf0f3f5), Color(0xFFe6f2ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: isRegistered
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👋 Hello, ${companyName ?? 'Entrepreneur'}!",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Here's your startup overview today 🚀",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 25),
                      _dashboardCard(
                        title: "Funding Progress",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("You've raised 50% of your target."),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.grey[300],
                              color: const Color(0xFF0AD98D),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _dashboardCard(
                        title: "Profile Strength",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("80% complete"),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.8,
                              backgroundColor: Colors.grey[300],
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _dashboardCard(
                        title: "Investor Leads",
                        content: const Text(
                            "5 investors have shown interest this week! 🎉"),
                      ),
                      const SizedBox(height: 16),
                      _dashboardCard(
                        title: "Team Activity",
                        content: const Text(
                            "Your team added 3 new milestones this week."),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _quickAction(Icons.person, "Edit Profile"),
                          _quickAction(Icons.show_chart, "View Stats"),
                          _quickAction(Icons.message, "Chats"),
                          _quickAction(Icons.timeline, "Milestones"),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Recent Updates",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      _updateTile("🎯 You reached 50% of your funding goal!"),
                      _updateTile("💬 2 new investor messages received"),
                      _updateTile("📈 Milestone: Beta Launch Completed!"),
                    ],
                  ),
                )
              : _emptyState(),
        ),
      ),
    );
  }

  Widget _dashboardCard({required String title, required Widget content}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFF20AC82),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _updateTile(String text) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      leading: const Icon(Icons.fiber_manual_record,
          size: 12, color: Color(0xFF0AD98D)),
      title: Text(text, style: const TextStyle(fontSize: 13)),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.business, size: 80, color: Colors.grey),
        const SizedBox(height: 12),
        const Text(
          "No Company Registered!",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        const Text(
          "Tap below to register and unlock dashboard features.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CompanyFormScreen()),
            );
            checkCompanyRegistration();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 32, 172, 130),
          ),
          child: const Text(
            'Register Company',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
