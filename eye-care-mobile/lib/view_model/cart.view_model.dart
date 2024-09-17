import 'dart:convert';
import 'package:eyecare_mobile/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:eyecare_mobile/model/cart.model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartViewModel extends ChangeNotifier {
  List<Cart> carts = [];
  bool isPaymentVerified = false;

  int getCartCount() {
    return carts.fold(0, (total, cart) => total + cart.quantity);
  }

  double getCartTotal() {
    return carts.fold(0, (total, cart) => total + cart.quantity * cart.price);
  }

  void addCartItem(Cart cartItemToAdd) {
    bool itemExists = false;

    carts = carts.map((cart) {
      if (cart.productId == cartItemToAdd.productId) {
        itemExists = true;
        return Cart(
          productId: cart.productId,
          name: cart.name,
          image: cart.image,
          price: cart.price,
          quantity: cart.quantity + cartItemToAdd.quantity,
        );
      }
      return cart;
    }).toList();

    if (!itemExists) {
      carts.add(cartItemToAdd);
    }

    saveCart();

    notifyListeners();
  }

  void removeCartItem(Cart cartItemToRemove) {
    carts = carts.map((cart) {
      if (cart.productId == cartItemToRemove.productId) {
        return Cart(
          productId: cart.productId,
          name: cart.name,
          image: cart.image,
          price: cart.price,
          quantity: cart.quantity - 1,
        );
      }
      return cart;
    }).toList();

    carts = carts.where((cart) => cart.quantity > 0).toList();

    saveCart();

    notifyListeners();
  }

  void clearCartItem(Cart cartItemToClear) {
    carts = carts
        .where((cart) => cart.productId != cartItemToClear.productId)
        .toList();

    saveCart();

    notifyListeners();
  }

  Future<void> loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartsPref = prefs.getString('ec_carts');

    if (cartsPref == null) return;
    final List data = jsonDecode(cartsPref);
    carts = data.map((cart) => Cart.fromJsonPrefs(cart)).toList();
    notifyListeners();
  }

  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> cartJson =
        carts.map((cart) => cart.toJson()).toList();

    await prefs.setString('ec_carts', jsonEncode(cartJson));
  }

  Future<String> checkout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final cartItems = carts.map((cart) => cart.toJson()).toList();

    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/paymongo/checkout'),
      body: jsonEncode({"cartItems": cartItems, "flutter_user_id": userID}),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      resetCart();
      return data["checkoutUrl"] as String;
    } else {
      throw Exception('An error occurred on checkout.');
    }
  }

  Future<void> getIsPaymentVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/own-payment'),
      body: jsonEncode({"flutter_user_id": userID}),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic>? data = jsonDecode(response.body);

    if (data == null) return;

    if (response.statusCode == 200) {
      isPaymentVerified = data["isVerified"] as bool;
      notifyListeners();
    } else {
      throw Exception('An error occurred on checkout.');
    }
  }

  Future<String> placeOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/payment'),
      body: jsonEncode({"flutter_user_id": userID}),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data["message"] as String;
    } else {
      throw Exception('An error occurred on checkout.');
    }
  }

  Future<String> verifyPayment(otp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString('ec_user_token');

    final response = await http.post(
      Uri.parse('${Constants.eyecareApiUrl}/verify-payment'),
      body: jsonEncode({"flutter_user_id": userID, "otp": otp}),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data["message"] as String;
    } else {
      throw Exception(data["message"] as String);
    }
  }

  void resetCart() {
    carts = [];
    notifyListeners();
  }
}
