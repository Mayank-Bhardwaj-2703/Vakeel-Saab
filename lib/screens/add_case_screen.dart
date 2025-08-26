import 'package:flutter/material.dart';

class AddCaseScreen extends StatefulWidget {
  const AddCaseScreen({super.key});

  @override
  State<AddCaseScreen> createState() => _AddCaseScreenState();
}

class _AddCaseScreenState extends State<AddCaseScreen> {
  final TextEditingController caseNumberController = TextEditingController();
  final TextEditingController caseTitleController = TextEditingController();
  final TextEditingController assignedToController = TextEditingController();

  void _saveCase() {
    if (caseNumberController.text.isEmpty ||
        caseTitleController.text.isEmpty ||
        assignedToController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    final newCase = {
      "caseNumber": caseNumberController.text,
      "title": caseTitleController.text,
      "assignedTo": assignedToController.text.split(","),
      "status": "Pending",
    };

    Navigator.pop(context, newCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Case")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: caseNumberController,
              decoration: const InputDecoration(
                labelText: "Case Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: caseTitleController,
              decoration: const InputDecoration(
                labelText: "Case Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: assignedToController,
              decoration: const InputDecoration(
                labelText: "Assigned To (comma-separated)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveCase,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 40,
                ),
              ),
              child: const Text("Save Case"),
            ),
          ],
        ),
      ),
    );
  }
}
