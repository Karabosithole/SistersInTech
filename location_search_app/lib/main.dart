import 'package:flutter/material.dart';
import 'package:location_search_app/models/payout_partner_location.dart';
import 'package:location_search_app/services/search_service.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              widget.onSearch('');
            },
          ),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onChanged: (value) {
          widget.onSearch(value);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Branch Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Branch Search'),
        ),
        body: const BranchSearchWidget(),
      ),
    );
  }
}

class BranchSearchWidget extends StatefulWidget {
  const BranchSearchWidget({Key? key}) : super(key: key);

  @override
  _BranchSearchWidgetState createState() => _BranchSearchWidgetState();
}

class _BranchSearchWidgetState extends State<BranchSearchWidget> {
  final SearchService _searchService = SearchService();
  List<PayoutPartnerLocation> searchResults = [];

  void _onSearch(String query) {
    _searchService.searchPartners(query).then((value) {
      setState(() {
        searchResults = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(onSearch: _onSearch),
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final result = searchResults[index];
              return ListTile(
                title: Text(result.name),
                subtitle: Text(result.address.streetAddress),
                onTap: () {
                  // Handle tap on search result
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
