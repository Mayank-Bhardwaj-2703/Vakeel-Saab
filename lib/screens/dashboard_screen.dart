import 'dart:io';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'case_tracking_screen.dart';
import 'cause_list_screen.dart';
import 'judgments_screen.dart';
import 'advocate_profile_screen.dart';
import 'login_screen.dart';
import 'management_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  File? _profileImage;

  Future<void> _viewProfile() async {
    final updatedImage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );

    if (updatedImage != null && mounted) {
      setState(() {
        _profileImage = updatedImage;
      });
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vakeel Saab Dashboard"),
        actions: [
          // Profile Picture
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: _viewProfile,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/images/default_profile.jpg')
                          as ImageProvider,
              ),
            ),
          ),

          // Dropdown Menu
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                _viewProfile();
              } else if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.blue),
                    SizedBox(width: 10),
                    Text("View Profile"),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text("Logout"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
              "Management",
              Icons.manage_accounts,
              const ManagementScreen(),
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
