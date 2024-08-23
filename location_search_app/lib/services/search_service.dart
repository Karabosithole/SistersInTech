import 'package:flutter/foundation.dart';
import 'package:location_search_app/models/payout_partner.dart';
import 'package:location_search_app/models/payout_partner_location.dart';
import 'package:location_search_app/services/mukuru_service.dart';

class SearchService {
  Future<List<PayoutPartnerLocation>> searchPartners(String query) async {
    if (query.isEmpty || query.length < 3) {
      return [];
    }

    MukuruService mukuruService = MukuruService();
    if (kDebugMode) {
      print('Searching for: $query');
    }
    List<PayoutPartner> partners = await mukuruService.fetchData(500);

    /*List<PayoutPartnerLocation> locations = [];
    for (PayoutPartner partner in partners) {
      List<PayoutPartnerLocation> partnerLocations =
          await mukuruService.fetchLocations(partner.guid, 500);
      locations.addAll(partnerLocations);
    }*/

    List<PayoutPartnerLocation> locations = await mukuruService.fetchLocations(
        "6564", 500); // Fetch locations for the first partner

    // Set the search query to lowercase where address is also converted to lowercase
    query = query.toLowerCase();
    List<PayoutPartnerLocation> searchResults = [];
    for (PayoutPartnerLocation location in locations) {
      if (location.name.toLowerCase().contains(query) ||
          location.description.toLowerCase().contains(query) ||
          location.address.city.toLowerCase().contains(query)) {
        searchResults.add(location);
      }
    }

    // remove duplicates for search results
    searchResults = searchResults.toSet().toList();
    //return searchResults.cast<PayoutPartnerLocation>();
    for (var element in searchResults) {
      print(element.name);
    }
    return searchResults;
  }
}
