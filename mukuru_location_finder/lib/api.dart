import 'dart:convert';
import 'package:http/http.dart' as http;


void fetchData() async {
  final url = Uri.parse('https://api-ubt.mukuru.com/taurus/v1/resources/pay-out-partners');
  
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response data: $data');
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}

void main() {
  fetchData();
}
