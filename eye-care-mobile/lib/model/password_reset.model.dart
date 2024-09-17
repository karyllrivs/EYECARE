class PasswordResetModel {
  final String message;
  PasswordResetModel({required this.message});

  factory PasswordResetModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetModel(
      message: json['message'],
    );
  }
}
