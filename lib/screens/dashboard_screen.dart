import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {
  final electricityController =
  TextEditingController();
  final travelController =
  TextEditingController();
  final foodController =
  TextEditingController();

  String carbonScore = "0";
  String ecoLevel = "Beginner";
  String suggestion =
      "Enter your lifestyle data to get premium AI eco insights.";

  void calculateCarbon() {
    int electricity =
        int.tryParse(electricityController.text) ?? 0;
    int travel =
        int.tryParse(travelController.text) ?? 0;
    int food =
        int.tryParse(foodController.text) ?? 0;

    double score =
        (electricity * 0.4) +
            (travel * 0.3) +
            (food * 0.5);

    setState(() {
      carbonScore = score.toStringAsFixed(2);

      if (score < 80) {
        ecoLevel = "Eco Starter";
      } else if (score < 150) {
        ecoLevel = "Eco Smart";
      } else {
        ecoLevel = "Carbon Alert";
      }

      suggestion = AIService.getRecommendation(
        carbonScore: score,
        electricity: electricity,
        travel: travel,
        food: food,
      );
    });
  }

  Widget inputField(
      String label,
      IconData icon,
      TextEditingController controller,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          labelText: label,
          filled: true,
          fillColor:
          Theme.of(context).brightness ==
              Brightness.dark
              ? const Color(0xFF1B2A24)
              : Colors.white,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget statCard(
      String value,
      String label,
      IconData icon,
      Color color,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color:
          Theme.of(context).brightness ==
              Brightness.dark
              ? const Color(0xFF1B2A24)
              : Colors.white,
          borderRadius:
          BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
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
        title: const Text("CarbonPulse"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(30),
                gradient:
                const LinearGradient(
                  colors: [
                    Color(0xFF0F9D58),
                    Color(0xFF00C853),
                    Color(0xFF00BFA5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green
                        .withOpacity(0.35),
                    blurRadius: 25,
                    offset:
                    const Offset(0, 12),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: const [
                      Text(
                        "Today’s Carbon Score",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.eco,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    carbonScore,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 54,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    ecoLevel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.18),
                      borderRadius:
                      BorderRadius.circular(
                          30),
                    ),
                    child: const Text(
                      "AI-powered lifestyle insight",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                statCard(
                  "₹0",
                  "Saved",
                  Icons.savings,
                  Colors.green,
                ),
                const SizedBox(width: 14),
                statCard(
                  "0",
                  "Day Streak",
                  Icons.local_fire_department,
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              "Lifestyle Inputs",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            inputField(
              "Electricity Units",
              Icons.electric_bolt,
              electricityController,
            ),

            inputField(
              "Travel Distance (km)",
              Icons.directions_car,
              travelController,
            ),

            inputField(
              "Meat Meals Per Week",
              Icons.restaurant,
              foodController,
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateCarbon,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.green,
                  foregroundColor:
                  Colors.white,
                  padding:
                  const EdgeInsets
                      .symmetric(
                    vertical: 18,
                  ),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        20),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  "Generate AI Carbon Insight",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1B2A24)
                    : Colors.white,
                borderRadius:
                BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.08),
                    blurRadius: 20,
                    offset:
                    const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.auto_awesome,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Premium AI Recommendation",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    suggestion,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}