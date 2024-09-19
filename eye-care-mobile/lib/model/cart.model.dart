class Cart {
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;

  Cart({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory Cart.fromJsonPrefs(Map<String, dynamic> json) {
    return Cart(
      productId: json["_id"],
      name: json["name"],
      image: json["image"],
      price: json["price"],
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': productId,
        'name': name,
        'image': image,
        'price': price,
        'quantity': quantity,
      };
}
