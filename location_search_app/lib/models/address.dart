class Address {
  final String streetAddress;
  final String city;

  Address({
    required this.streetAddress,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      streetAddress: json['streetAddress'],
      city: json['city'],
    );
  }
}
