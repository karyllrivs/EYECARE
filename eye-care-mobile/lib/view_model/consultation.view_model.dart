import 'package:eyecare_mobile/model/consultation.model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConsultationViewModel extends ChangeNotifier {
  List<ConsultationModel> consultations = [];
  List<ConsultationSlotModel> consultationSlots = [];

  Future<void> fetchUserConsultations() async {
    if (consultations.isNotEmpty) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/consultations/$userID'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      consultations =
          data.map((json) => ConsultationModel.fromJsonFetch(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load consultations.');
    }
  }

  Future<void> createConsultation(ConsultationModel consultation) async {
    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/consultations'),
      body: jsonEncode(consultation.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      consultations.add(ConsultationModel.fromJsonCreate(data));
      notifyListeners();
    } else {
      throw Exception('Failed to create consultation.');
    }
  }

  Future<void> fetchAvailableConsultationSlots() async {
    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/consultation-available-slots'),
      headers: {'Content-Type': 'application/json'},
    );

    final List data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      consultationSlots = data
          .map((json) => ConsultationSlotModel.fromJsonFetch(json))
          .toList();
    } else {
      throw Exception('Failed to load consultation slots.');
    }
  }
}
