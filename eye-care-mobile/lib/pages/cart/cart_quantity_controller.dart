import 'package:eyecare_mobile/model/cart.model.dart';
import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartQuantityController extends StatefulWidget {
  const CartQuantityController({
    super.key,
    required this.theme,
    required this.cart,
  });

  final ThemeData theme;
  final Cart cart;

  @override
  State<CartQuantityController> createState() => _CartQuantityControllerState();
}

class _CartQuantityControllerState extends State<CartQuantityController> {
  int cartQuantity = 0;

  @override
  void didChangeDependencies() {
    cartQuantity = widget.cart.quantity;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CartQuantityController oldWidget) {
    if (oldWidget.cart != widget.cart) {
      cartQuantity = widget.cart.quantity;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<CartViewModel>().addCartItem(
                      Cart(
                        productId: widget.cart.productId,
                        name: widget.cart.name,
                        image: widget.cart.image,
                        price: widget.cart.price,
                        quantity: 1,
                      ),
                    );
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.theme.colorScheme.onSurface.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "$cartQuantity",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<CartViewModel>().removeCartItem(widget.cart);
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.theme.colorScheme.onSurface.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.remove,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
