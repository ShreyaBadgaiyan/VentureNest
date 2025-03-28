// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:ui/investor_screens/imakeprofilescreen.dart';

// // class InvestorProfileView extends StatelessWidget {
// //   const InvestorProfileView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final uid = FirebaseAuth.instance.currentUser!.uid;

// //     return Scaffold(
// //       body: FutureBuilder<DocumentSnapshot>(
// //         future:
// //             FirebaseFirestore.instance.collection('investors').doc(uid).get(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (!snapshot.hasData || !snapshot.data!.exists) {
// //             return const Center(
// //               child: Text('No Profile Found. Please complete your profile.'),
// //             );
// //           }

// //           var data = snapshot.data!.data() as Map<String, dynamic>;

// //           return SingleChildScrollView(
// //             padding: const EdgeInsets.all(20),
// //             child: Column(
// //               children: [
// //                 const CircleAvatar(
// //                   radius: 50,
// //                   backgroundColor: Color(0xFF0AD98D),
// //                   child: Icon(Icons.person, color: Colors.white, size: 50),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 _buildInfoCard('Full Name', data['name']),
// //                 _buildInfoCard('Company', data['company']),
// //                 _buildInfoCard('Position', data['position']),
// //                 _buildInfoCard('Investment Focus', data['focus']),
// //                 _buildInfoCard('Contact', data['contact']),
// //                 const SizedBox(height: 30),
// //                 ElevatedButton.icon(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (_) => const InvestorProfileScreen()),
// //                     );
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: const Color(0xFF0AD98D),
// //                     minimumSize: const Size(double.infinity, 50),
// //                   ),
// //                   icon: const Icon(Icons.edit),
// //                   label: const Text("Edit Profile"),
// //                 )
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildInfoCard(String label, String value) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey[50],
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.shade300,
// //             blurRadius: 5,
// //             offset: const Offset(0, 3),
// //           )
// //         ],
// //       ),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Icon(Icons.arrow_right, color: Colors.black54),
// //           const SizedBox(width: 8),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(label,
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, color: Colors.black87)),
// //                 const SizedBox(height: 4),
// //                 Text(value.isNotEmpty ? value : 'N/A',
// //                     style: const TextStyle(color: Colors.black54)),
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ui/investor_screens/imakeprofilescreen.dart';
// import 'dart:math';

// class InvestorProfileView extends StatelessWidget {
//   const InvestorProfileView({super.key});

//   String getRandomAvatarUrl() {
//     final random = Random();
//     // Generates a random number between 1 and 1000
//     int avatarSeed = random.nextInt(1000);
//     // Using DiceBear Avatars API (You can replace this with any avatar API)
//     return 'https://api.dicebear.com/7.x/personas/svg?seed=$avatarSeed';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final uid = FirebaseAuth.instance.currentUser!.uid;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Investor Profile'),
//         backgroundColor: const Color(0xFF20AC82),
//       ),
//       backgroundColor: Colors.grey[100],
//       body: FutureBuilder<DocumentSnapshot>(
//         future:
//             FirebaseFirestore.instance.collection('investors').doc(uid).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return const Center(
//               child: Text('No Profile Found. Please complete your profile.'),
//             );
//           }

//           var data = snapshot.data!.data() as Map<String, dynamic>;
//           final avatarUrl = getRandomAvatarUrl();

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(avatarUrl),
//                   backgroundColor: Colors.white,
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   data['name'] ?? '',
//                   style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   data['position'] ?? '',
//                   style: const TextStyle(
//                       fontSize: 16, color: Colors.grey, letterSpacing: 0.5),
//                 ),
//                 const SizedBox(height: 30),
//                 _buildInfoCard(Icons.business, 'Company', data['company']),
//                 _buildInfoCard(
//                     Icons.trending_up, 'Investment Focus', data['focus']),
//                 _buildInfoCard(Icons.contact_mail, 'Contact', data['contact']),
//                 const SizedBox(height: 30),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => const InvestorProfileScreen()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF20AC82),
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                   ),
//                   icon: const Icon(Icons.edit, color: Colors.white),
//                   label: const Text(
//                     "Edit Profile",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildInfoCard(IconData icon, String label, String value) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           )
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: const Color(0xFF20AC82), size: 28),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black87)),
//                 const SizedBox(height: 6),
//                 Text(
//                   value.isNotEmpty ? value : 'N/A',
//                   style: const TextStyle(color: Colors.black54, fontSize: 15),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/investor_screens/imakeprofilescreen.dart';

class InvestorProfileView extends StatelessWidget {
  const InvestorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('investors').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('No Profile Found. Please complete your profile.'),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFF20AC82),
                    ),
                    Icon(Icons.person,
                        size: 50, color: Colors.white), // Person icon
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  data['name'] ?? '',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 5),
                Text(
                  data['position'] ?? '',
                  style: const TextStyle(
                      fontSize: 16, color: Colors.grey, letterSpacing: 0.5),
                ),
                const SizedBox(height: 30),
                _buildInfoCard(Icons.business, 'Company', data['company']),
                _buildInfoCard(
                    Icons.trending_up, 'Investment Focus', data['focus']),
                _buildInfoCard(Icons.contact_mail, 'Contact', data['contact']),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const InvestorProfileScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF20AC82),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF20AC82), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 6),
                Text(
                  value.isNotEmpty ? value : 'N/A',
                  style: const TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
