import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/location_finder_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mukuru Location Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Update with your theme colors
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/about': (context) => const AboutUsScreen(),
        '/faq': (context) => const FAQScreen(),
        '/location-finder': (context) => const LocationFinderScreen(),
      },
    );
  }
}
