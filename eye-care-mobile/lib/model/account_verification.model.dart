class AccountVerificationModel {
  final String message;
  AccountVerificationModel({required this.message});

  factory AccountVerificationModel.fromJson(Map<String, dynamic> json) {
    return AccountVerificationModel(
      message: json['message'],
    );
  }
}
