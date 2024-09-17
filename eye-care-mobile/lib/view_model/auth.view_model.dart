import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:eyecare_mobile/model/auth.model.dart';
import 'package:eyecare_mobile/shared/services/routes.config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  GoRouter _routerConfig = GoRouter(routes: unprotectedRoutes);
  Auth? _authenticatedUser;

  GoRouter get routerConfig => _routerConfig;
  Auth? get authenticatedUser => _authenticatedUser;

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    if (userID == null) {
      _routerConfig = GoRouter(routes: unprotectedRoutes);
      notifyListeners();
      return;
    }

    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/profiles/$userID'),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _authenticatedUser = Auth.fromJsonProfile({"id": userID, ...data});
    } else {
      throw Exception('Failed to load user.');
    }

    _routerConfig = GoRouter(routes: protectedRoutes);
    notifyListeners();
  }

  Future<void> reloadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final response = await http.get(
      Uri.parse('${Constants.eyecareApiUrl}/profiles/$userID'),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _authenticatedUser = Auth.fromJsonProfile({"id": userID, ...data});
      notifyListeners();
    } else {
      throw Exception('Failed to load user.');
    }
  }

  Future<String> signupUser(Auth user) async {
    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/register'),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data["message"];
    } else {
      throw Exception(data["message"]);
    }
  }

  Future<dynamic> loginUser(Auth user) async {
    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/login'),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _authenticatedUser = Auth.fromJsonLogin(data);
      saveAuthenticatedUser(_authenticatedUser!);
      loadUser();
    } else {
      final notVerified = data["notVerified"];
      if (notVerified != null) {
        return data["message"];
      } else {
        throw Exception(data["message"]);
      }
    }
  }

  Future<dynamic> googleLoginUser(String email) async {
    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/auth-google'),
      body: jsonEncode({"email": email}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 302) {
      String redirectedUrl = response.headers['location']!;
      final newResponse = await http.get(Uri.parse(redirectedUrl));

      final Map<String, dynamic> data = jsonDecode(newResponse.body);

      if (newResponse.statusCode == 200) {
        _authenticatedUser = Auth.fromJsonLogin(data);
        saveAuthenticatedUser(_authenticatedUser!);
        loadUser();
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Did not redirected to the google login on server.");
    }
  }

  Future<void> updateUserProfile(Auth user) async {
    final response = await http.put(
      Uri.parse('${Constants.eyecareApiUrl}/profiles/${user.id}'),
      body: jsonEncode(
        user.toJson(),
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      reloadUser();
    } else {
      throw Exception('Failed to update user.');
    }
  }

  Future<void> saveAuthenticatedUser(Auth user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ec_user_token', user.id);
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final response = await http.delete(
      Uri.parse('${Constants.eyecareApiUrl}/logout'),
      body: jsonEncode({"flutter_user_id": userID}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      await prefs.remove('ec_user_token');
      _authenticatedUser = null;
      loadUser();
    } else {
      throw Exception('Failed to update user.');
    }
  }
}
