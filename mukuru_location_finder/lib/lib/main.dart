import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/location_finder_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/faq_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mukuru Location Finder',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/location-finder': (context) => const LocationFinderScreen(),
        '/about': (context) => const AboutUsScreen(),
        '/faq': (context) => const FAQScreen(),
      },
    );
  }
}


