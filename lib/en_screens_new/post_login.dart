// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:core/en_screens_new/company_registration_form.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class EntrepreneurDashboard extends StatefulWidget {
//   @override
//   _EntrepreneurDashboardState createState() => _EntrepreneurDashboardState();
// }

// class _EntrepreneurDashboardState extends State<EntrepreneurDashboard> {
//   bool isRegistered = false;
//   final uid = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   void initState() {
//     super.initState();
//     checkCompanyRegistration();
//   }

//   void checkCompanyRegistration() async {
//     DocumentSnapshot doc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .collection('companyDetails')
//         .doc('details')
//         .get();

//     if (doc.exists) {
//       setState(() {
//         isRegistered = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Entrepreneur Dashboard')),
//       body: Center(
//         child: isRegistered
//             ? const Text('✅ Company Already Registered')
//             : ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => CompanyFormScreen()),
//                   );
//                 },
//                 child: const Text('Register Your Company'),
//               ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/entrepreneur_screens/profile.dart';
import 'package:ui/entrepreneur_screens/register.dart';

class EntrepreneurDashboard extends StatefulWidget {
  @override
  _EntrepreneurDashboardState createState() => _EntrepreneurDashboardState();
}

class _EntrepreneurDashboardState extends State<EntrepreneurDashboard> {
  bool isRegistered = false;
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrepreneur Dashboard')),
      body: Center(
        child: isRegistered
            // ? const Text('✅ Company Already Registered')
            ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CompanyProfileScreen(
                              uid: uid,
                            )),
                  );
                },
                child: const Text('Profile'),
              )
            : ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CompanyFormScreen()),
                  );
                },
                child: const Text('Register Your Company'),
              ),
      ),
    );
  }
}
