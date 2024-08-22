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
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pageSizeController = TextEditingController();
  final TextEditingController _pageController = TextEditingController();
  late Future<List<dynamic>> payoutPartners;

  @override
  void initState() {
    super.initState();
    payoutPartners = Future.value([]);
  }

  Future<List<dynamic>> fetchPayoutPartners(String country, int pageSize, int page) async {
    final response = await http.get(
      Uri.parse(
          'https://api-ubt.mukuru.com/taurus/v1/resources/pay-out-partners?country=$country&page_size=$pageSize&page=$page'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load payout partners');
    }
  }

  void _search() {
    final country = _countryController.text;
    final pageSize = int.tryParse(_pageSizeController.text) ?? 10;
    final page = int.tryParse(_pageController.text) ?? 1;

    setState(() {
      payoutPartners = fetchPayoutPartners(country, pageSize, page);
    });
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
              decoration: const InputDecoration(labelText: 'Country (ISO2 code)'),
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
              onPressed: _search,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: payoutPartners,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var location = snapshot.data?[index];
                        return ListTile(
                          title: Text(location['name'] ?? 'Unknown Location'),
                          subtitle: Text(location['address'] ?? 'No address provided'),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No locations found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
