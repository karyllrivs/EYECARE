class ObjectModel {
  final String productId; 
  final String image;

  const ObjectModel(
      {required this.productId, 
      required this.image});

  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      productId: json["product_id"], 
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': productId, 
        'image': image,
      };
}
