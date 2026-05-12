import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Please login first")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Eco Report"),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .collection("carbon_history")
            .orderBy("createdAt", descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          double totalCarbon = 0;
          int totalUnits = 0;

          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            totalCarbon += (data["carbonScore"] ?? 0).toDouble();
            totalUnits += (data["electricityUnits"] ?? 0) as int;
          }

          final avgCarbon =
          docs.isEmpty ? 0 : totalCarbon / docs.length;

          String grade;
          String insight;

          if (totalCarbon < 50) {
            grade = "A+";
            insight =
            "Excellent sustainability performance. Your carbon footprint is currently low.";
          } else if (totalCarbon < 150) {
            grade = "B";
            insight =
            "Good progress. Focus on reducing electricity and travel emissions for better results.";
          } else {
            grade = "C";
            insight =
            "Your footprint is high. CarbonPulse recommends reducing AC usage, fuel travel, and high-energy habits.";
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0F9D58),
                        Color(0xFF00BFA5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Monthly Sustainability Report",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Text(
                        "Grade $grade",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 46,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        user.email ?? "CarbonPulse User",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    _reportCard(
                      title: "Total CO₂",
                      value: totalCarbon.toStringAsFixed(2),
                      icon: Icons.eco,
                      color: Colors.green,
                      isDark: isDark,
                    ),

                    const SizedBox(width: 14),

                    _reportCard(
                      title: "Units",
                      value: totalUnits.toString(),
                      icon: Icons.electric_bolt,
                      color: Colors.orange,
                      isDark: isDark,
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    _reportCard(
                      title: "Records",
                      value: docs.length.toString(),
                      icon: Icons.history,
                      color: Colors.blue,
                      isDark: isDark,
                    ),

                    const SizedBox(width: 14),

                    _reportCard(
                      title: "Avg CO₂",
                      value: avgCarbon.toStringAsFixed(1),
                      icon: Icons.analytics,
                      color: Colors.purple,
                      isDark: isDark,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                _premiumSection(
                  isDark: isDark,
                  title: "AI Insight",
                  icon: Icons.auto_awesome,
                  content: insight,
                ),

                const SizedBox(height: 18),

                _premiumSection(
                  isDark: isDark,
                  title: "Recommended Actions",
                  icon: Icons.task_alt,
                  content:
                  "1. Track electricity every week.\n2. Reduce AC usage during peak hours.\n3. Use public transport twice a week.\n4. Maintain low-carbon food habits.",
                ),

                const SizedBox(height: 18),

                _premiumSection(
                  isDark: isDark,
                  title: "Eco Achievement Summary",
                  icon: Icons.workspace_premium,
                  content:
                  "You are building consistent sustainability habits. Continue scanning bills and monitoring your carbon trend to unlock more rewards.",
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "PDF export coming in final APK version.",
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Export Report"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _reportCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B2A24) : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _premiumSection({
    required bool isDark,
    required String title,
    required IconData icon,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B2A24) : Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}