import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('About Us'),
      ),
      body: Container(
        color: Colors.orange[900], // Set the background color to black
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.2), // Light white background with opacity
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Know more about the Mukuru Location Finder!',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color for better contrast
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Our app is dedicated to simplifying the process of locating payout locations for collecting remittance. Our mission is to provide a user-friendly platform that ensures you can find the services you need quickly and efficiently. We are a team of passionate professionals, including experienced developers, innovative designers, and dedicated support staff, all committed to delivering a seamless experience. If you have any questions, suggestions, or need assistance, please don’t hesitate to reach out to us at contact@mukuru.com. We’re here to help and look forward to serving you!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Text color for better contrast
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/aboutus.jpeg', // Replace with your image path
                height: 300, // Adjust height as needed
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
