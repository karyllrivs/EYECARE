import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/object.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ObjectViewModel extends ChangeNotifier {
  List<ObjectModel> objects = [];

  Future<void> fetchObjects() async {
    if (objects.isNotEmpty) return;
    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/objects'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      objects = data.map((json) => ObjectModel.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load products.');
    }
  }

  List<ObjectModel> fetchObjectModels(String productId) {
    return objects.where((object) => object.productId == productId).toList();
  }
}
