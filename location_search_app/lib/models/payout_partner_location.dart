import 'package:location_search_app/models/address.dart';
import 'package:location_search_app/models/contact.dart';
import 'package:location_search_app/models/coordinates.dart';

class PayoutPartnerLocation {
  final String guid;
  final String name;
  final String description;
  final List<String> currencies;
  final Address address;
  final Coordinates coordinates;
  final Contact contact;

  PayoutPartnerLocation({
    required this.guid,
    required this.name,
    required this.description,
    required this.currencies,
    required this.address,
    required this.coordinates,
    required this.contact,
  });

  factory PayoutPartnerLocation.fromJson(Map<String, dynamic> json) {
    return PayoutPartnerLocation(
      guid: json['guid'],
      name: json['name'],
      description: json['description'],
      currencies: List<String>.from(json['currencies']),
      address: Address.fromJson(json['address']),
      coordinates: Coordinates.fromJson(json['coordinates']),
      contact: Contact.fromJson(json['contact']),
    );
  }
}
