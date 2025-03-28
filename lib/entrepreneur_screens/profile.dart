import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui/edit_profile.dart';
import 'package:ui/entrepreneur_screens/register.dart';

class CompanyProfileScreen extends StatelessWidget {
  final String uid;

  const CompanyProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('companies').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return _buildEmptyState(context);
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(data),
                const SizedBox(height: 16),
                _buildSection(
                  title: "Company Overview",
                  children: [
                    _infoRow("Company Name", data['companyName']),
                    _infoRow("Tagline", data['companyTagline']),
                    _infoRow("Website", data['companywebsite']),
                    _infoRow("Industry", data['industry']),
                    _infoRow("Vision", data['vision']),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: "Financials",
                  children: [
                    _infoRow("Investment Ask", data['investmentAsk']),
                    _infoRow("Equity Offered", data['equityOffered']),
                    _infoRow("Funding Stage", data['fundingStage']),
                    _infoRow(
                        "Total Funding Raised", data['totalFundingRaised']),
                    _infoRow("Valuation", data['valuation']),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: "Company Stats",
                  children: [
                    _infoRow("Founded", data['yearFounded']),
                    _infoRow("Employees", data['noOfEmployees']),
                    _infoRow("Customer Base", data['customerBase']),
                    _infoRow("Annual Revenue", data['annualRevenue']),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: "More Info",
                  children: [
                    _infoRow("Contact", data['contactUs']),
                    _infoRow("Prior Investors", data['priorInvestors']),
                    _infoRow("Target Market", data['targetMarket']),
                    _infoRow("Problem", data['problemStatement']),
                    _infoRow("Solution", data['solution']),
                    _infoRow("Milestones", data['milestones']),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: "Revenue Info",
                  children: [
                    _infoRow("2020", data['lllllyearrevenue']),
                    _infoRow("2021", data['llllyearrevenue']),
                    _infoRow("2022", data['lllyearrevenue']),
                    _infoRow("2023", data['llyearrevenue']),
                    _infoRow("2024", data['lyearrevenue']),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CompanyEditScreen(uid: uid)),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: const Text("Edit Profile",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 32, 172, 130),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.business, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "You haven't registered your company yet.",
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 32, 172, 130),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CompanyFormScreen()),
                );
              },
              child: const Text("Register Your Company"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> data) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: data['logoUrl'] != null && data['logoUrl'] != ''
              ? NetworkImage(data['logoUrl'])
              : null,
          backgroundColor: Colors.grey[300],
          child: data['logoUrl'] == null || data['logoUrl'] == ''
              ? const Icon(Icons.business, size: 50, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          data['companyName'] ?? '',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 32, 172, 130))),
            const SizedBox(height: 8),
            ...children
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
          Expanded(
            child: Text(
              value ?? '-',
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }
}
