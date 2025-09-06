// UPCOMING FEATURES :-
//1. AI CHAT
//2. MY DIARY
import 'dart:io';
import 'package:flutter/material.dart';
//import 'chat_screen.dart';
import 'case_tracking_screen.dart';
import 'cause_list_screen.dart';
import 'judgments_screen.dart';
import 'advocate_profile_screen.dart';
import 'login_screen.dart';
import 'management_screen.dart';
//import 'diary_dashboard_screen.dart';
import '../widgets/app_footer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  File? _profileImage;
  String advocateName = "Adv. Mayank Bhardwaj"; // Placeholder
  List<Map<String, dynamic>> myCasesList = []; // Temporary empty list

  //Navigate to Profile Screen
  Future<void> _viewProfile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          email: "adv.mayank@gmail.com", // Replace with real data if available
          dob: "15-08-1998", // Replace with real data if available
        ),
      ),
    );
  }

  //Logout method
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
        backgroundColor: Colors.blue,
        elevation: 3,
        actions: [
          //Profile Picture Icon in AppBar
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

          //Dropdown Menu
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

      body: Column(
        children: [
          // Expanded Grid for Dashboard Cards
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  // dashboardCard(context, "AI Chat", Icons.chat, const ChatScreen()),
                  dashboardCard(
                    context,
                    "Case Tracking",
                    Icons.search,
                    const CaseTrackingScreen(),
                  ),
                  // dashboardCard(context, "My Diary", Icons.calendar_month, DiaryDashboardScreen(myCases: myCasesList)),
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
                    CauseListScreen(advocateName: advocateName),
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
          ),

          // Beta message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [Colors.blue, Colors.indigo],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: const Text(
                        "🚀 Beta MVP Version",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "⚖️ We are here to digitalize lawyers' work and make case management faster and smarter.\n "
                      "Upcoming features include AI Chat and Advocate's Diary updates.\n "
                      "Give us feedback and suggest exciting features that can make your work more comfortable and productive!\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer
          const AppFooter(),
        ],
      ),
    );
  }

  // Dashboard Card Widget
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
