import 'package:flutter/material.dart';

class JudgmentsScreen extends StatelessWidget {
  const JudgmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> judgments = [
      {
        "title": "State vs mayank bhardwaj",
        "court": "Supreme Court",
        "date": "05 Sep 2025",
        "summary": "Land dispute judgment favoring the state.",
      },
      {
        "title": "vaibhav bhardwaj vs ABC Pvt Ltd",
        "court": "High Court",
        "date": "22 Aug 2025",
        "summary": "Employment termination ruled illegal.",
      },
      {
        "title": "Manoj vs State",
        "court": "District Court",
        "date": "10 Aug 2025",
        "summary": "Bail granted in criminal case.",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Recent Judgments")),
      body: ListView.builder(
        itemCount: judgments.length,
        itemBuilder: (context, index) {
          final judgment = judgments[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judgment['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Court: ${judgment['court']}"),
                      Text("Date: ${judgment['date']}"),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    judgment['summary']!,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
