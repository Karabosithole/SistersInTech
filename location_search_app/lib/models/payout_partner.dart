class PayoutPartner {
  final String guid;
  final String name;
  final String description;
  final List<String> currencies;
  final List<String> countryCodes;
  final List<String> logos;
  final List<String> productTypes;

  PayoutPartner({
    required this.guid,
    required this.name,
    required this.description,
    required this.currencies,
    required this.countryCodes,
    required this.logos,
    required this.productTypes,
  });

  factory PayoutPartner.fromJson(Map<String, dynamic> json) {
    return PayoutPartner(
      guid: json['guid'],
      name: json['name'],
      description: json['description'],
      currencies: List<String>.from(json['currencies']),
      countryCodes: List<String>.from(json['countryCodes']),
      logos: [], //List<String>.from(json['logos']),
      productTypes: List<String>.from(json['productTypes']),
    );
  }
}
