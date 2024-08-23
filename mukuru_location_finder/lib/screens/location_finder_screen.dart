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
    final String country = _countryController.text.toUpperCase();
    final String pageSize = _pageSizeController.text.isNotEmpty ? _pageSizeController.text : '10';
    final String page = _pageController.text.isNotEmpty ? _pageController.text : '1';

    final url = Uri.parse(
        'https://api-ubt.mukuru.com/taurus/v1/resources/pay-out-partners?country=$country&page_size=$pageSize&page=$page');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['items'] != null) {
        return data['items'] as List<dynamic>;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load payout locations');
    }
  }

  Future<List<String>> fetchCountrySuggestions(String query) async {
    List<String> countries = ['ZB Bank', 'ZA', 'ZW', 'MW', 'MZ', 'NG'];
    return countries.where((country) => country.toLowerCase().startsWith(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Payout Locations'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
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
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No locations found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return ListTile(
                          title: Text(item['name'] ?? 'No name'),
                          subtitle: Text(item['description'] ?? 'No description'),
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
