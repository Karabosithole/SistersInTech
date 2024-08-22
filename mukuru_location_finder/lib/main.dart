import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        primarySwatch: Colors.blue,
      ),
      home: const LocationFinderScreen(),
    );
  }
}

class LocationFinderScreen extends StatefulWidget {
  const LocationFinderScreen({super.key});

  @override
  _LocationFinderScreenState createState() => _LocationFinderScreenState();
}

class _LocationFinderScreenState extends State<LocationFinderScreen> {
  // Step 1: Add TextEditingController instances
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pageSizeController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();

  // Future variable to hold API data
  late Future<List<dynamic>> payoutPartners;

  @override
  void initState() {
    super.initState();
    payoutPartners = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Payout Locations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Step 2: Add TextField widgets for user input
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: 'Country'),
            ),
            TextField(
              controller: _pageSizeController,
              decoration: const InputDecoration(labelText: 'Page Size'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _pageController,
              decoration: const InputDecoration(labelText: 'Page'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Add other widgets here...
          ],
        ),
      ),
    );
  }
}
