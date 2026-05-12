class AIService {

  static String getRecommendation({
    required double carbonScore,
    required int electricity,
    required int travel,
    required int food,
  }) {

    if (electricity > 300) {

      return
        "High electricity usage detected. Try reducing AC usage and switch to LED bulbs.";

    } else if (travel > 50) {

      return
        "Travel footprint is high. Consider public transport or carpooling.";

    } else if (food > 10) {

      return
        "Reducing meat consumption can significantly lower your carbon footprint.";

    } else if (carbonScore < 50) {

      return
        "Excellent eco lifestyle! Keep maintaining your sustainable habits.";

    } else {

      return
        "Good progress. Small daily sustainable actions can reduce your footprint further.";
    }
  }
}