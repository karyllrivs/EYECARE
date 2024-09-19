import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/password_token.model.dart';
import 'package:http/http.dart' as http;

class PasswordTokenViewModel {
  Future<String> confirmTokenForPasswordReset(
      token, password, confirmPassword) async {
    final Map<String, dynamic> body = {
      "token": token,
      "password": password,
      "confirmPassword": confirmPassword
    };

    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/password-token'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    PasswordTokenModel passwordTokenModel = PasswordTokenModel.fromJson(data);

    if (response.statusCode == 200) {
      return passwordTokenModel.message;
    } else {
      throw Exception(passwordTokenModel.message);
    }
  }
}
