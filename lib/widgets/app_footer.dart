import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ), // slightly reduced padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Company Logo
          Image.asset("assets/images/primary_logo.png", height: 55),
          const SizedBox(height: 2), // reduced space between logo and text
          // Powered by text
          const Text(
            "Powered by Codlyn Softwares",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
