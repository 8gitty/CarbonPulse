import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() =>
      _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController messageController =
  TextEditingController();

  bool isTyping = false;

  List<Map<String, String>> messages = [
    {
      "role": "bot",
      "message":
      "Hi, I’m CarbonPulse AI 🌱 Ask me how to reduce carbon, save electricity, or improve your eco score.",
    },
  ];

  void sendMessage({String? quickMessage}) async {
    String userMessage =
        quickMessage ?? messageController.text.trim();

    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({
        "role": "user",
        "message": userMessage,
      });

      isTyping = true;
    });

    messageController.clear();

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    setState(() {
      messages.add({
        "role": "bot",
        "message": generateReply(userMessage),
      });

      isTyping = false;
    });
  }

  String generateReply(String message) {
    final text = message.toLowerCase();

    if (text.contains("electricity") ||
        text.contains("power") ||
        text.contains("ac")) {
      return "Your electricity footprint can be reduced by using AC at 24°C, switching to LED bulbs, and turning off standby devices. Small changes can reduce monthly usage by 10–20%.";
    }

    if (text.contains("travel") ||
        text.contains("fuel") ||
        text.contains("bike") ||
        text.contains("car")) {
      return "For travel emissions, try public transport twice a week, carpooling, or walking for short trips. This can reduce fuel cost and carbon impact together.";
    }

    if (text.contains("food") ||
        text.contains("meat") ||
        text.contains("diet")) {
      return "Food choices matter too. Reducing meat meals by even 2 meals per week can lower your footprint while saving money.";
    }

    if (text.contains("score") ||
        text.contains("carbon")) {
      return "Your carbon score is mainly affected by electricity, travel, and food habits. Focus first on the category with the highest usage for maximum impact.";
    }

    if (text.contains("save money") ||
        text.contains("cost")) {
      return "Best money-saving eco actions: reduce AC usage, avoid unnecessary cab rides, use public transport, and track electricity bills monthly.";
    }

    return "Good question 🌱 A practical way to start is: track your usage, find the highest-impact habit, then make one small change for 7 days.";
  }

  Widget quickChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        sendMessage(quickMessage: text);
      },
    );
  }

  Widget chatBubble(Map<String, String> message) {
    final isUser = message["role"] == "user";

    return Align(
      alignment:
      isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.all(15),
        constraints: const BoxConstraints(maxWidth: 310),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.green
              : Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1B2A24)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft:
            Radius.circular(isUser ? 20 : 4),
            bottomRight:
            Radius.circular(isUser ? 4 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          message["message"]!,
          style: TextStyle(
            color: isUser ? Colors.white : null,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CarbonPulse AI"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F9D58),
                  Color(0xFF00BFA5),
                ],
              ),
            ),
            child: const Text(
              "Ask your personal sustainability assistant",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                quickChip("How to save electricity?"),
                const SizedBox(width: 8),
                quickChip("Reduce travel carbon"),
                const SizedBox(width: 8),
                quickChip("Improve my score"),
                const SizedBox(width: 8),
                quickChip("Save money"),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isTyping) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("CarbonPulse AI is typing..."),
                    ),
                  );
                }

                return chatBubble(messages[index]);
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF101815)
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Ask CarbonPulse AI...",
                      filled: true,
                      fillColor: isDark
                          ? const Color(0xFF1B2A24)
                          : Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.green,
                  child: IconButton(
                    onPressed: () => sendMessage(),
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}