import 'package:eyecare_mobile/model/rating.model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:http/http.dart' as http;

class RatingViewModel extends ChangeNotifier {
  Future<List<Rating>> fetchRatingsByProductId(productId) async {
    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/ratings/$productId'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data.map((json) => Rating.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Ratings.');
    }
  }

  Future<void> createRating(Rating rating) async {
    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/ratings'),
      body: jsonEncode(rating.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create Rating.');
    }
  }
}
