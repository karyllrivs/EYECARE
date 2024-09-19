class Auth {
  final String id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? password;
  final String? mobile;
  final String? address;
  final String? image;
  final bool isVerified;

  Auth({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    this.password,
    this.mobile,
    this.address,
    this.image,
    this.isVerified = false,
  });

  factory Auth.fromJsonProfile(Map<String, dynamic> json) {
    return Auth(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      address: json['address'],
      mobile: json['mobile_number'],
      image: json['image'],
    );
  }

  factory Auth.fromJsonSignup(Map<String, dynamic> json) {
    return Auth(
      id: json['user']['_id'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      email: json['user']['email'],
      isVerified: json['isVerified'] ?? false,
    );
  }

  factory Auth.fromJsonLogin(Map<String, dynamic> json) {
    return Auth(
      id: json['currentUser']['_id'],
      firstName: json['currentUser']['first_name'],
      lastName: json['currentUser']['last_name'],
      email: json['currentUser']['email'],
      isVerified: json['currentUser']['isVerified'] ?? false,
    );
  }

  factory Auth.fromJsonUpdate(Map<String, dynamic> json) {
    return Auth(
      id: json['profile']['_id'],
      firstName: json['profile']['first_name'],
      lastName: json['profile']['last_name'],
      email: json['profile']['email'],
      address: json['profile']['address'],
      mobile: json['profile']['mobile_number'],
      image: json['profile']['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'flutter_user_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'mobile_number': mobile,
        'address': address,
        'image': image,
        'password': password,
      };
}
