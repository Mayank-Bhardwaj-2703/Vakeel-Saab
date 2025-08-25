import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const mayankapp());
}

class mayankapp extends StatelessWidget {
  const mayankapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vakeel Saab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }
}
