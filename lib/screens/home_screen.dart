import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import 'scanner_screen.dart';
import 'profile_screen.dart';
import 'chatbot_screen.dart';
import 'rewards_screen.dart';
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const DashboardScreen(),
    const AnalyticsScreen(),
    const ScannerScreen(),
    const ChatbotScreen(),
    const ReportScreen(),
    const RewardsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Analytics",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: "Scanner",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "AI",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Report",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: "Rewards",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),


        ],
      ),
    );
  }
}