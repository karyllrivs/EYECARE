import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/product.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductViewModel extends ChangeNotifier {
  List<Product> products = [];
  List<Product> searchProducts = [];

  Future<void> fetchProducts() async {
    if (products.isNotEmpty) return;
    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/products/'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      products = data.map((json) => Product.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load products.');
    }
  }

  Product fetchProduct(String productId) {
    return products.firstWhere((product) => product.id == productId);
  }

  Future<void> fetchProductsByKeyword(keyword) async {
    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/products-search/$keyword'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      searchProducts = data.map((json) => Product.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load products.');
    }
  }
}
