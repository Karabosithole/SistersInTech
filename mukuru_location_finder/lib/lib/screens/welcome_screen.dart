import 'package:flutter/material.dart';

// Define a constant for the color
const Color appBarButtonColor = Color.fromARGB(255, 151, 69, 10);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mukuru Location Finder'),
        backgroundColor: appBarButtonColor, // Use the constant color
      ),
      body: Stack(
        children: <Widget>[
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/wallpaper2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of the background image
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Welcome to the Mukuru Location Finder App!',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white, // To make text stand out on background
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/location-finder');
                          },
                          child: const Text(
                            'Find Payout Locations',
                            style: TextStyle(
                                color: Colors.white), // White text color
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBarButtonColor, // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0), // Consistent padding
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/about');
                          },
                          child: const Text(
                            'About Us',
                            style: TextStyle(
                                color: Colors.white), // White text color
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBarButtonColor, // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0), // Consistent padding
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/faq');
                          },
                          child: const Text(
                            'FAQ',
                            style: TextStyle(
                                color: Colors.white), // White text color
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appBarButtonColor, // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0), // Consistent padding
                          ),
                        ),
                      ],
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
