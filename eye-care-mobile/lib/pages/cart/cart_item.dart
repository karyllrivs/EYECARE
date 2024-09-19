import 'package:eyecare_mobile/model/cart.model.dart';
import 'package:eyecare_mobile/pages/cart/cart_quantity_controller.dart';
import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';
import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Cart? cart;

  @override
  void didChangeDependencies() {
    cart = cart ?? widget.cart;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    if (oldWidget.cart != widget.cart) {
      cart = widget.cart;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuerySize = MediaQuery.of(context).size;

    return Container(
      height: mediaQuerySize.height * 0.2,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                image: DecorationImage(
                  image: NetworkImage(
                    getFilePath(cart!.image),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cart!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                Text(
                  "₱${cart!.price}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CartQuantityController(theme: theme, cart: cart!)
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              context.read<CartViewModel>().clearCartItem(widget.cart);
            },
            icon: Icon(
              Icons.delete_outline,
              color: theme.colorScheme.error,
            ),
          )
        ],
      ),
    );
  }
}
