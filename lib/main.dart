import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CarbonPulseApp());
}

class CarbonPulseApp extends StatefulWidget {
  const CarbonPulseApp({super.key});

  @override
  State<CarbonPulseApp> createState() =>
      _CarbonPulseAppState();
}

class _CarbonPulseAppState extends State<CarbonPulseApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      toggleTheme: toggleTheme,
      isDarkMode: isDarkMode,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CarbonPulse',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:
        isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: const LoginScreen(),
      ),
    );
  }
}

class ThemeProvider extends InheritedWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ThemeProvider({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
    required super.child,
  });

  static ThemeProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return isDarkMode != oldWidget.isDarkMode;
  }
}