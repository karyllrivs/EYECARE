class PasswordTokenModel {
  final String message;
  PasswordTokenModel({required this.message});

  factory PasswordTokenModel.fromJson(Map<String, dynamic> json) {
    return PasswordTokenModel(
      message: json['message'],
    );
  }
}
