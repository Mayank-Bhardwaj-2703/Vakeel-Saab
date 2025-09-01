import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'signup_screen.dart';
import '../widgets/app_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Secondary Logo (centered & smaller)
          Positioned.fill(
            child: Opacity(
              opacity: 0.06, // Faded watermark effect
              child: Center(
                child: Image.asset(
                  "assets/images/secondary_logo.png",
                  width: MediaQuery.of(context).size.width * 0.9, // Reduce size
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Header with Primary Logo
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "assets/images/primary_logo.png",
                    height: 110, // Increased logo size
                  ),
                ),

                // Lowered Main Content to Center
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 80,
                          ), // Push content further down
                          // App Title with Better Font Style
                          const Text(
                            "Vakeel Saab",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Colors.black87,
                              fontFamily: 'Roboto', // Modern font
                            ),
                          ),
                          const SizedBox(height: 50),

                          // Email / Phone Field
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Enter Email",
                              labelStyle: const TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Login Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Sign Up Button
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
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
          ),
        ],
      ),
    );
  }
}
