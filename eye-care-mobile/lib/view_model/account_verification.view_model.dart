import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/account_verification.model.dart';
import 'package:http/http.dart' as http;

class AccountVerificationViewModel {
  Future<String> sendAccountVerificationToken(token) async {
    final Map<String, dynamic> body = {
      "token": token,
    };

    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/verify-account'),
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    AccountVerificationModel passwordTokenModel =
        AccountVerificationModel.fromJson(data);

    if (response.statusCode == 200) {
      return passwordTokenModel.message;
    } else {
      throw Exception(passwordTokenModel.message);
    }
  }
}
