class Category {
  final String id;
  final String name;
  final String description;
  final bool isInNavbar;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isInNavbar,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      isInNavbar: json['isInNavbar'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'isInNavbar': isInNavbar,
      };
}
