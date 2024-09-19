class Product {
  final String id;
  final String categoryId;
  final String categoryName;
  final String name;
  final String image;
  final String description;
  final double price;
  final int stock;

  Product({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'].toDouble(),
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'category_name': categoryName,
        'name': name,
        'image': image,
        'description': description,
        'price': price,
        'stock': stock,
      };
}
