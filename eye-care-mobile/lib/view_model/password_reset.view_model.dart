import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/password_reset.model.dart';
import 'package:http/http.dart' as http;

class PasswordResetViewModel {
  Future<String> createTokenForPasswordReset(email) async {
    final Map<String, dynamic> body = {"email": email};
    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/password-reset'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    PasswordResetModel passwordResetModel = PasswordResetModel.fromJson(data);

    if (response.statusCode == 200) {
      return passwordResetModel.message;
    } else {
      throw Exception(passwordResetModel.message);
    }
  }
}
