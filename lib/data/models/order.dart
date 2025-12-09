class Order {
  final int id;
  final String status;
  final int totalPrice;

  Order({required this.id, required this.status, required this.totalPrice});

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      status: map['status'] as String,
      totalPrice: map['total_price'] ?? 0,
    );
  }
}
