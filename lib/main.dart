import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Needed for async before runApp

  // ✅ Check if user is already logged in
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(mayankapp(isLoggedIn: isLoggedIn));
}

class mayankapp extends StatelessWidget {
  final bool isLoggedIn; // ✅ Add variable

  const mayankapp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vakeel Saab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),

      // ✅ If logged in → Dashboard, else → Login
      home: isLoggedIn ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
