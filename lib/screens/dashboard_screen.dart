import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'case_tracking_screen.dart';
import 'cause_list_screen.dart';
import 'judgments_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vakeel Saab Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            dashboardCard(context, "AI Chat", Icons.chat, const ChatScreen()),
            dashboardCard(
              context,
              "Case Tracking",
              Icons.search,
              const CaseTrackingScreen(),
            ),
            dashboardCard(
              context,
              "Cause List",
              Icons.list_alt,
              const CauseListScreen(),
            ),
            dashboardCard(
              context,
              "Judgments",
              Icons.book,
              const JudgmentsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.blue),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
