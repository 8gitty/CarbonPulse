import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import 'login_screen.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void logout(BuildContext context) async {
    await AuthService().logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final email = user?.email ?? "No email";

    final firstLetter =
    email.isNotEmpty
        ? email[0].toUpperCase()
        : "U";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [

            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.green,

              child: Text(
                firstLetter,

                style: const TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              email,

              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Eco Smart User",

              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            Card(
              child: ListTile(

                leading: const Icon(
                  Icons.verified_user,
                  color: Colors.green,
                ),

                title: const Text(
                  "Email Verification",
                ),

                subtitle: Text(
                  user?.emailVerified == true
                      ? "Verified"
                      : "Not Verified",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(

                leading: Icon(
                  ThemeProvider.of(context)
                      .isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,

                  color: Colors.green,
                ),

                title: const Text(
                  "App Theme",
                ),

                subtitle: Text(
                  ThemeProvider.of(context)
                      .isDarkMode
                      ? "Dark Mode"
                      : "Light Mode",
                ),

                trailing: Switch(
                  value:
                  ThemeProvider.of(context)
                      .isDarkMode,

                  onChanged: (_) {

                    ThemeProvider.of(context)
                        .toggleTheme();
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: () =>
                    logout(context),

                icon:
                const Icon(Icons.logout),

                label:
                const Text("Logout"),

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.red,

                  foregroundColor:
                  Colors.white,

                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape:
                  RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(
                        16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}