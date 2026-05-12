import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  Widget badgeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool unlocked,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: unlocked
            ? color.withOpacity(0.12)
            : Colors.grey.withOpacity(0.1),

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: unlocked
              ? color
              : Colors.grey.shade400,
          width: 2,
        ),
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 30,
            backgroundColor:
            unlocked ? color : Colors.grey,

            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                    FontWeight.bold,

                    color: unlocked
                        ? color
                        : Colors.grey,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,

                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            unlocked
                ? Icons.verified
                : Icons.lock,

            color:
            unlocked ? color : Colors.grey,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Eco Rewards"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(28),

              decoration: BoxDecoration(

                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00C853),
                    Color(0xFF00BFA5),
                  ],
                ),

                borderRadius:
                BorderRadius.circular(30),
              ),

              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    "Eco Points",

                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "1240",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Level 5 • Sustainability Hero",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Achievements",

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            badgeCard(
              title: "Eco Starter",
              subtitle:
              "Completed your first carbon scan.",

              icon: Icons.eco,
              color: Colors.green,
              unlocked: true,
            ),

            badgeCard(
              title: "7 Day Streak",
              subtitle:
              "Used CarbonPulse for 7 consecutive days.",

              icon:
              Icons.local_fire_department,

              color: Colors.orange,
              unlocked: true,
            ),

            badgeCard(
              title: "Low Carbon Hero",
              subtitle:
              "Maintained low carbon score for 1 week.",

              icon: Icons.energy_savings_leaf,

              color: Colors.teal,
              unlocked: true,
            ),

            badgeCard(
              title: "Green Traveler",
              subtitle:
              "Reduced travel emissions significantly.",

              icon: Icons.directions_bike,

              color: Colors.blue,
              unlocked: false,
            ),

            badgeCard(
              title: "AI Master",
              subtitle:
              "Used AI assistant 25 times.",

              icon: Icons.smart_toy,

              color: Colors.purple,
              unlocked: false,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1B2A24)
                    : Colors.white,

                borderRadius:
                BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color:
                    Colors.black.withOpacity(
                        0.06),

                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Icon(
                        Icons.workspace_premium,
                        color: Colors.amber,
                      ),

                      SizedBox(width: 10),

                      Text(
                        "Next Goal",

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  Text(
                    "Reduce your electricity usage by 15% this week to unlock the Green Traveler badge and earn 300 Eco Points.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}