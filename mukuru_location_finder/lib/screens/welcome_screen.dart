import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Mukuru'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the Mukuru Location Finder App!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/location-finder');
              },
              child: const Text('Find Payout Locations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: const Text('About Us'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/faq');
              },
              child: const Text('FAQ'),
            ),
          ],
        ),
      ),
    );
  }
}
