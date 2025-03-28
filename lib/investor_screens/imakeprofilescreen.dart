// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class InvestorProfileScreen extends StatefulWidget {
//   const InvestorProfileScreen({super.key});

//   @override
//   State<InvestorProfileScreen> createState() => _InvestorProfileScreenState();
// }

// class _InvestorProfileScreenState extends State<InvestorProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final companyController = TextEditingController();
//   final positionController = TextEditingController();
//   final investmentFocusController = TextEditingController();
//   final contactController = TextEditingController();

//   final uid = FirebaseAuth.instance.currentUser!.uid;

//   Future<void> saveProfile() async {
//     await FirebaseFirestore.instance.collection('investors').doc(uid).set({
//       'name': nameController.text.trim(),
//       'company': companyController.text.trim(),
//       'position': positionController.text.trim(),
//       'focus': investmentFocusController.text.trim(),
//       'contact': contactController.text.trim(),
//       'uid': uid,
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Profile Saved Successfully!')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeading('Personal Information'),
//               const SizedBox(height: 12),
//               _buildTextField('Full Name', nameController),
//               const SizedBox(height: 12),
//               _buildTextField('Company', companyController),
//               const SizedBox(height: 12),
//               _buildTextField('Position/Title', positionController),
//               const SizedBox(height: 12),
//               _buildTextField('Investment Focus (e.g., AI, Healthcare)',
//                   investmentFocusController),
//               const SizedBox(height: 12),
//               _buildTextField('Contact Email / Phone', contactController),
//               const SizedBox(height: 24),
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 32, 172, 130),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 40, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30))),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       saveProfile();
//                     }
//                   },
//                   child: const Text(
//                     'Save Profile',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeading(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: Color.fromARGB(255, 32, 172, 130),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: Colors.grey[100],
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         return null;
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvestorProfileScreen extends StatefulWidget {
  const InvestorProfileScreen({super.key});

  @override
  State<InvestorProfileScreen> createState() => _InvestorProfileScreenState();
}

class _InvestorProfileScreenState extends State<InvestorProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final positionController = TextEditingController();
  final investmentFocusController = TextEditingController();
  final contactController = TextEditingController();

  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> saveProfile() async {
    await FirebaseFirestore.instance.collection('investors').doc(uid).set({
      'name': nameController.text.trim(),
      'company': companyController.text.trim(),
      'position': positionController.text.trim(),
      'focus': investmentFocusController.text.trim(),
      'contact': contactController.text.trim(),
      'uid': uid,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile Saved Successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF20AC82),
        title: const Text(
          'Investor Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading('Personal Details'),
              const SizedBox(height: 16),
              _buildTextField('Full Name', nameController, Icons.person),
              const SizedBox(height: 16),
              _buildTextField('Company', companyController, Icons.business),
              const SizedBox(height: 16),
              _buildTextField('Position/Title', positionController, Icons.work),
              const SizedBox(height: 16),
              _buildTextField('Investment Focus (e.g., AI, Healthcare)',
                  investmentFocusController, Icons.lightbulb_outline),
              const SizedBox(height: 16),
              _buildTextField('Contact Email / Phone', contactController,
                  Icons.email_outlined),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save_alt, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF20AC82),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveProfile();
                    }
                  },
                  label: const Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF20AC82),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF20AC82)),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF20AC82)),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
