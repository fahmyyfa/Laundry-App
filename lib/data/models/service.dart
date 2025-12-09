class Service {
  final int id;
  final String name;
  final String description;
  final int basePrice;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
  });

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] ?? '',
      basePrice: map['base_price'] as int,
    );
  }
}
