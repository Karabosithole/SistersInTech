class Contact {
  final String type;
  final String? value;

  Contact({
    required this.type,
    this.value,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      type: json['type'],
      value: json['value'],
    );
  }
}
