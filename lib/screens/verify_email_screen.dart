import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState
    extends State<VerifyEmailScreen> {
  final AuthService authService = AuthService();

  bool isChecking = false;
  bool isSending = false;

  void checkVerification() async {
    setState(() {
      isChecking = true;
    });

    final verified =
    await authService.isEmailVerified();

    setState(() {
      isChecking = false;
    });

    if (verified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Email not verified yet. Please check your inbox/spam.",
          ),
        ),
      );
    }
  }

  void resendEmail() async {
    setState(() {
      isSending = true;
    });

    final error =
    await authService.resendVerificationEmail();

    setState(() {
      isSending = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error == null
              ? "Verification email sent again."
              : error,
        ),
      ),
    );
  }

  void backToLogin() async {
    await authService.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email =
        authService.currentUser?.email ?? "your email";

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mark_email_unread,
                size: 90,
                color: Colors.green,
              ),

              const SizedBox(height: 20),

              const Text(
                "Verify Your Email",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "We sent a verification link to:\n$email",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                  isChecking ? null : checkVerification,
                  child: isChecking
                      ? const CircularProgressIndicator()
                      : const Text("I Verified My Email"),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed:
                  isSending ? null : resendEmail,
                  child: isSending
                      ? const CircularProgressIndicator()
                      : const Text("Resend Verification Email"),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: backToLogin,
                child: const Text("Back to Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}