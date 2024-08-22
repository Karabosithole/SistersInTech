import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
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
      home: LocationFinderScreen(),
    );
  }
}

class LocationFinderScreen extends StatefulWidget {
  const LocationFinderScreen({super.key});

  @override
  _LocationFinderScreenState createState() => _LocationFinderScreenState();
}

class _LocationFinderScreenState extends State<LocationFinderScreen> {
  late Future<List<dynamic>> payoutPartners;

  @override
  void initState() {
    super.initState();
    payoutPartners = fetchPayoutPartners();
  }

  Future<List<dynamic>> fetchPayoutPartners() async {
    final response = await http.get(
      Uri.parse('https://api-ubt.mukuru.com/taurus/v1/resources/pay-out-partners'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load payout partners');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Payout Locations'),
      ),
      body: FutureBuilder<List<dynamic>>(
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
    );
  }
}
