class Rating {
  final String id;
  final String userId;
  final String productId;
  final String review;
  final int rating;

  Rating({
    required this.id,
    required this.userId,
    required this.productId,
    required this.review,
    required this.rating,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['_id'],
      userId: json['user_id'],
      productId: json['product_id'],
      review: json['review'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
        'flutter_user_id': userId,
        'product_id': productId,
        'review': review,
        'rating': rating,
      };
}
