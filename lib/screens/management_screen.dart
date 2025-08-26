import 'package:flutter/material.dart';
import 'add_case_screen.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  List<Map<String, dynamic>> cases = [
    {
      "caseNumber": "CIV12345",
      "title": "Property Dispute",
      "assignedTo": ["Junior A", "Intern B"],
      "status": "Pending",
    },
    {
      "caseNumber": "CRIM67890",
      "title": "Criminal Appeal",
      "assignedTo": ["Junior C"],
      "status": "In Progress",
    },
  ];

  void _addNewCase(Map<String, dynamic> newCase) {
    setState(() {
      cases.add(newCase);
    });
  }

  void _updateStatus(int index, String status) {
    setState(() {
      cases[index]["status"] = status;
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Case Management"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newCase = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCaseScreen()),
              );

              if (newCase != null) {
                _addNewCase(newCase);
              }
            },
          ),
        ],
      ),
      body: cases.isEmpty
          ? const Center(
              child: Text(
                "No cases added yet. Tap + to add a case.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: cases.length,
              itemBuilder: (context, index) {
                final caseData = cases[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      caseData["title"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Case No: ${caseData["caseNumber"]}"),
                        Text(
                          "Assigned To: ${caseData["assignedTo"].join(", ")}",
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              "Status: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                              value: caseData["status"],
                              items: const [
                                DropdownMenuItem(
                                  value: "Pending",
                                  child: Text("Pending"),
                                ),
                                DropdownMenuItem(
                                  value: "In Progress",
                                  child: Text("In Progress"),
                                ),
                                DropdownMenuItem(
                                  value: "Completed",
                                  child: Text("Completed"),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  _updateStatus(index, value);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.circle,
                      color: _getStatusColor(caseData["status"]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
