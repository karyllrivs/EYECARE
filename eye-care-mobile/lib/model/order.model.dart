class Order {
  final String id;
  final String productId;
  final String image;
  final String deliveredOn;
  final String status;
  final int quantity;
  final double total;

  Order({
    required this.id,
    required this.productId,
    required this.image,
    required this.deliveredOn,
    required this.status,
    required this.quantity,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      productId: json['product_id'],
      image: json['image'],
      deliveredOn: json['delivered_on'],
      status: json['status'],
      quantity: json['quantity'],
      total: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'image': image,
        'delivered_on': deliveredOn,
        'status': status,
        'quantity': quantity,
        'total': total,
      };
}
