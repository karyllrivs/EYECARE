import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/category.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryViewModel extends ChangeNotifier {
  List<Category> categories = [];

  Future<void> fetchCategories() async {
    if (categories.isNotEmpty) return;
    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/categories/'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      categories = data.map((json) => Category.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load categories.');
    }
  }
}
