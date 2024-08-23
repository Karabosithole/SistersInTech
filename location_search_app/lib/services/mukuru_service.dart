import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:location_search_app/models/payout_partner.dart';
import 'package:location_search_app/models/payout_partner_location.dart';
import 'package:location_search_app/utils/constants.dart';

class MukuruService {
  Future<List<PayoutPartner>> fetchData(int pageSize) async {
    final response = await http
        .get(Uri.parse('${Constants.payOutPartnersUrl}?page_size=$pageSize'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      //final items = jsonData['items'] as List<PayoutPartner>;
      final items = jsonData['items'] as List<dynamic>;
      return items.map((item) => PayoutPartner.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<PayoutPartnerLocation>> fetchLocations(
      String guid, int pageSize) async {
    final response = await http.get(Uri.parse(
        '${Constants.payOutPartnersUrl}/$guid/locations?page_size=$pageSize'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final items = jsonData['items'] as List<dynamic>;
      final locations =
          items.map((item) => PayoutPartnerLocation.fromJson(item)).toList();
      return locations;
    } else {
      throw Exception('Failed to fetch locations');
    }
  }
}
