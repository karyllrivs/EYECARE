import 'package:eyecare_mobile/model/cart.model.dart';
import 'package:eyecare_mobile/pages/cart/cart_item.dart';
import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:flutter/material.dart';
import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<Cart> carts = [];
  double cartTotal = 0;

  bool isPaymentVerified = false;

  void checkout() async {
    try {
      String checkoutUrl = await context.read<CartViewModel>().checkout();
      goToURL(checkoutUrl);
    } catch (e) {
      if (mounted) showResultDialog(context, false, message: e.toString());
    }
  }

  void placeOrder() async {
    try {
      String message = await context.read<CartViewModel>().placeOrder();
      if (mounted) {
        showResultDialog(context, true, message: message, callback: () {
          context.push("/verify-payment");
        });
      }
    } catch (e) {
      if (mounted) showResultDialog(context, false, message: e.toString());
    }
  }

  Future<void> goToURL(link) async {
    Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    context.read<CartViewModel>().getIsPaymentVerified();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    carts = context.watch<CartViewModel>().carts;
    cartTotal = context.read<CartViewModel>().getCartTotal();

    isPaymentVerified = context.watch<CartViewModel>().isPaymentVerified;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      body: carts.isEmpty
          ? const Center(
              child: Text("Cart is empty."),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: carts.length,
                    itemBuilder: (_, index) {
                      final cart = carts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: CartItem(cart: cart),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  subtitle: Text(
                    "₱$cartTotal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  trailing: isPaymentVerified
                      ? ElevatedButton(
                          onPressed: checkout,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.payment),
                              Text("Checkout"),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: placeOrder,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.payment),
                              Text("Place Order"),
                            ],
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
