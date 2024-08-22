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
      // Set initial route
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/about': (context) => const AboutUsScreen(),
        '/faq': (context) => const FAQScreen(),
        '/location-finder': (context) => const LocationFinderScreen(),
        // Add routes for Sign-Up, Login, etc.
      },
    );
  }
}

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

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Mukuru is a leading financial services provider...'),
            // Add more details about the company.
          ],
        ),
      ),
    );
  }
}

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Q: How do I find a payout location?\nA: Use the location finder...'),
            // Add more FAQs.
          ],
        ),
      ),
    );
  }
}

class LocationFinderScreen extends StatefulWidget {
  const LocationFinderScreen({super.key});

  @override
  _LocationFinderScreenState createState() => _LocationFinderScreenState();
}

class _LocationFinderScreenState extends State<LocationFinderScreen> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pageSizeController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();

  late Future<List<dynamic>> payoutPartners;

  @override
  void initState() {
    super.initState();
    payoutPartners = Future.value([]);
  }

  Future<List<dynamic>> fetchPayoutLocations() async {
    final String country = _countryController.text;
    final String pageSize = _pageSizeController.text;
    final String page = _pageController.text;

    final response = await http.get(
      Uri.parse(
          'https://api-ubt.mukuru.com/taurus/v1/resources/pay-out-partners?country=$country&page_size=$pageSize&page=$page'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load payout locations');
    }
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
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: 'Country (ISO2 Code)'),
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  payoutPartners = fetchPayoutLocations();
                });
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<dynamic>>(
              future: payoutPartners,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No locations found');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]['name']),
                          subtitle: Text(snapshot.data![index]['address']),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Add classes for Sign-Up, Login, and other functionalities.

