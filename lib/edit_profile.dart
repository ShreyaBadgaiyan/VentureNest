// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompanyEditScreen extends StatefulWidget {
  final String uid;
  const CompanyEditScreen({super.key, required this.uid});

  @override
  State<CompanyEditScreen> createState() => _CompanyEditScreenState();
}

class _CompanyEditScreenState extends State<CompanyEditScreen> {
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    loadCompanyData();
  }

  void loadCompanyData() async {
    final doc = await FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.uid)
        .get();
    final data = doc.data() ?? {};

    for (var key in data.keys) {
      controllers[key] = TextEditingController(text: data[key]);
    }

    setState(() {});
  }

  Future<void> saveChanges() async {
    Map<String, String> updatedData = {};
    controllers.forEach((key, controller) {
      updatedData[key] = controller.text.trim();
    });

    await FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.uid)
        .update(updatedData);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Company',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 32, 172, 130),
      ),
      body: controllers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: controllers.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: entry.value,
                      decoration: InputDecoration(
                        labelText: entry.key,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: saveChanges,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 32, 172, 130),
              minimumSize: const Size(double.infinity, 50)),
          child: const Text(
            'Save Changes',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
