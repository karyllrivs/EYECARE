class Policy {
  final String id;
  final String name;
  final String content;
  final String dateCreated;

  Policy({
    required this.id,
    required this.name,
    required this.content,
    required this.dateCreated,
  });

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      id: json['_id'],
      name: json['name'],
      content: json['content'],
      dateCreated: json['date_created'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': content,
        'isInNavbar': dateCreated,
      };
}
