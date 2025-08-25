import 'package:flutter/material.dart';

class CauseListScreen extends StatelessWidget {
  const CauseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> causeList = [
      {
        "caseNo": "CNR12345",
        "court": "District Court",
        "hearingDate": "15 Sep 2025",
        "status": "Listed",
      },
      {
        "caseNo": "CNR67890",
        "court": "High Court",
        "hearingDate": "17 Sep 2025",
        "status": "Adjourned",
      },
      {
        "caseNo": "CNR270302",
        "court": "Supreme Court",
        "hearingDate": "27 mar 2002",
        "status": "Pending",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Cause List")),
      body: ListView.builder(
        itemCount: causeList.length,
        itemBuilder: (context, index) {
          final cause = causeList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              title: Text(
                "Case No: ${cause['caseNo']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Court: ${cause['court']}"),
                  Text("Hearing: ${cause['hearingDate']}"),
                ],
              ),
              trailing: Text(
                cause['status']!,
                style: TextStyle(
                  color: cause['status'] == "Listed"
                      ? Colors.green
                      : cause['status'] == "Pending"
                      ? Colors.orange
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
