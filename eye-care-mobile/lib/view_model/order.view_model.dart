import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/order.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderViewModel extends ChangeNotifier {
  List<Order> orders = [];

  Future<void> fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/orders/$userID'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      orders = data.map((json) => Order.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load orders.');
    }
  }
}
