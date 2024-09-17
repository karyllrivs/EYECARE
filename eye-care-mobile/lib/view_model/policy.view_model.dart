import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/policy.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PolicyViewModel extends ChangeNotifier {
  List<Policy> policies = [];

  Future<void> fetchPolicies() async {
    if (policies.isNotEmpty) return;
    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/policies/'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      policies = data.map((json) => Policy.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load policies.');
    }
  }
}
