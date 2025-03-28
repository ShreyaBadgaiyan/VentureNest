import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CompanyFormScreen extends StatefulWidget {
  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  // Controllers for fields (same as before)
  final companyNameController = TextEditingController();
  final companyTaglineController = TextEditingController();
  final companywebsiteController = TextEditingController();
  final investmentAskController = TextEditingController();
  final pitchVideoController = TextEditingController();
  final equityOfferedController = TextEditingController();
  final visionController = TextEditingController();
  final yearFoundedController = TextEditingController();
  final countryController = TextEditingController();
  final industryController = TextEditingController();
  final fundingStageController = TextEditingController();
  final totalFundingRaisedController = TextEditingController();
  final noOfEmployeesController = TextEditingController();
  final annualRevenueController = TextEditingController();
  final valuationController = TextEditingController();
  final customerBaseController = TextEditingController();
  final contactUsController = TextEditingController();
  final priorInvestorsController = TextEditingController();
  final targetMarketController = TextEditingController();
  final problemStatementController = TextEditingController();
  final solutionController = TextEditingController();
  final milestonesController = TextEditingController();
  final additionalNotesController = TextEditingController();
  final LYearRevenueController = TextEditingController();
  final LLYearRevenueController = TextEditingController();
  final LLLYearRevenueController = TextEditingController();
  final LLLLYearRevenueController = TextEditingController();
  final LLLLLYearRevenueController = TextEditingController();

  void nextPage() {
    if (_formKeys[_currentPage].currentState!.validate()) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _currentPage++;
      });
    }
  }

  void previousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    setState(() {
      _currentPage--;
    });
  }

  Future<void> submitForm() async {
    if (_formKeys[_currentPage].currentState!.validate()) {
      await FirebaseFirestore.instance.collection('companies').doc(uid).set({
        'companyName': companyNameController.text.trim(),
        'companyTagline': companyTaglineController.text.trim(),
        'companywebsite': companywebsiteController.text.trim(),
        'investmentAsk': investmentAskController.text.trim(),
        'pitchVideo': pitchVideoController.text.trim(),
        'equityOffered': equityOfferedController.text.trim(),
        'vision': visionController.text.trim(),
        'yearFounded': yearFoundedController.text.trim(),
        'country': countryController.text.trim(),
        'industry': industryController.text.trim(),
        'fundingStage': fundingStageController.text.trim(),
        'totalFundingRaised': totalFundingRaisedController.text.trim(),
        'noOfEmployees': noOfEmployeesController.text.trim(),
        'annualRevenue': annualRevenueController.text.trim(),
        'valuation': valuationController.text.trim(),
        'customerBase': customerBaseController.text.trim(),
        'contactUs': contactUsController.text.trim(),
        'priorInvestors': priorInvestorsController.text.trim(),
        'targetMarket': targetMarketController.text.trim(),
        'problemStatement': problemStatementController.text.trim(),
        'solution': solutionController.text.trim(),
        'milestones': milestonesController.text.trim(),
        'additionalNotes': additionalNotesController.text.trim(),
        'uid': uid,
        'lyearrevenue': LYearRevenueController.text.trim(),
        'llyearrevenue': LLYearRevenueController.text.trim(),
        'lllyearrevenue': LLLYearRevenueController.text.trim(),
        'llllyearrevenue': LLLLYearRevenueController.text.trim(),
        'lllllyearrevenue': LLLLLYearRevenueController.text.trim()
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Company Registered Successfully!'),
          backgroundColor: Color.fromARGB(255, 32, 172, 130),
        ),
      );

      Navigator.pop(context);
    }
  }

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 32, 172, 130), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget buildForm(String heading, List<Widget> fields, int index) {
    return Form(
      key: _formKeys[index],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 32, 172, 130),
              ),
            ),
            const SizedBox(height: 20),
            ...fields
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: e,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text('Company Registration')),
        backgroundColor: Color.fromARGB(255, 32, 172, 130),
        foregroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          buildForm(
              "Company Basics",
              [
                TextFormField(
                  controller: companyNameController,
                  decoration: customInputDecoration('Company Name'),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                TextFormField(
                  controller: companyTaglineController,
                  decoration: customInputDecoration('Tagline'),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                TextFormField(
                  controller: companywebsiteController,
                  decoration: customInputDecoration('Website'),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                TextFormField(
                  controller: investmentAskController,
                  decoration: customInputDecoration('Investment Ask'),
                  validator: (value) =>
                      value!.isEmpty ? "Required field" : null,
                ),
                TextFormField(
                  controller: pitchVideoController,
                  decoration: customInputDecoration('Pitch Video Link'),
                ),
                TextFormField(
                  controller: equityOfferedController,
                  decoration: customInputDecoration('Equity Offered %'),
                ),
                TextFormField(
                  controller: visionController,
                  decoration: customInputDecoration('Vision'),
                ),
                TextFormField(
                  controller: yearFoundedController,
                  decoration: customInputDecoration('Year Founded'),
                ),
              ],
              0),
          buildForm(
              "Business Metrics",
              [
                TextFormField(
                  controller: countryController,
                  decoration: customInputDecoration('Country'),
                ),
                TextFormField(
                  controller: industryController,
                  decoration: customInputDecoration('Industry'),
                ),
                TextFormField(
                  controller: fundingStageController,
                  decoration: customInputDecoration('Funding Stage'),
                ),
                TextFormField(
                  controller: totalFundingRaisedController,
                  decoration: customInputDecoration('Total Funding Raised'),
                ),
                TextFormField(
                  controller: noOfEmployeesController,
                  decoration: customInputDecoration('No. of Employees'),
                ),
                TextFormField(
                  controller: annualRevenueController,
                  decoration: customInputDecoration('Annual Revenue'),
                ),
                TextFormField(
                  controller: valuationController,
                  decoration: customInputDecoration('Valuation'),
                ),
                TextFormField(
                  controller: customerBaseController,
                  decoration: customInputDecoration('Customer Base'),
                ),
              ],
              1),
          buildForm(
              "Pitch Details",
              [
                TextFormField(
                  controller: contactUsController,
                  decoration: customInputDecoration('Contact Number'),
                ),
                TextFormField(
                  controller: priorInvestorsController,
                  decoration: customInputDecoration('Prior Investors'),
                ),
                TextFormField(
                  controller: targetMarketController,
                  decoration: customInputDecoration('Target Market'),
                ),
                TextFormField(
                  controller: problemStatementController,
                  decoration: customInputDecoration('Problem Statement'),
                ),
                TextFormField(
                  controller: solutionController,
                  decoration: customInputDecoration('Solution'),
                ),
                TextFormField(
                  controller: milestonesController,
                  decoration: customInputDecoration('Milestones'),
                ),
                TextFormField(
                  controller: additionalNotesController,
                  decoration: customInputDecoration('Additional Notes'),
                ),
              ],
              2),
          buildForm(
              "Revenue Details",
              [
                TextFormField(
                  controller: LYearRevenueController,
                  decoration: customInputDecoration('Revenue 2024'),
                ),
                TextFormField(
                  controller: LLYearRevenueController,
                  decoration: customInputDecoration('Revenue 2023'),
                ),
                TextFormField(
                  controller: LLLYearRevenueController,
                  decoration: customInputDecoration('Revenue 2022'),
                ),
                TextFormField(
                  controller: LLLLYearRevenueController,
                  decoration: customInputDecoration('Revenue 2021'),
                ),
                TextFormField(
                  controller: LLLLLYearRevenueController,
                  decoration: customInputDecoration('Revenue 2020'),
                ),
              ],
              3),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage > 0)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 32, 172, 130),
                ),
                onPressed: previousPage,
                child: const Text(
                  'Previous',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (_currentPage < 3)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 32, 172, 130),
                ),
                onPressed: nextPage,
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (_currentPage == 3)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 32, 172, 130),
                ),
                onPressed: submitForm,
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
