import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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

  Future<List<String>> fetchCountrySuggestions(String query) async {
    // You can use a local list of country names and codes, or fetch them from an API
    List<String> countries = ['ZA', 'ZW', 'MW', 'MZ', 'NG']; // Replace with actual list
    return countries.where((country) => country.toLowerCase().startsWith(query.toLowerCase())).toList();
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
            // Using TypeAheadFormField correctly
            TypeAheadFormField<String>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country (ISO2 Code)'),
              ),
              suggestionsCallback: (pattern) async {
                return fetchCountrySuggestions(pattern);
              },
              itemBuilder: (context, String suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (String suggestion) {
                _countryController.text = suggestion;
              },
              noItemsFoundBuilder: (context) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No suggestions found'),
              ),
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
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: payoutPartners,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No locations found');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index]['name']),
                          subtitle: Text(snapshot.data![index]['address']),
                        );
                      },
                    );
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

