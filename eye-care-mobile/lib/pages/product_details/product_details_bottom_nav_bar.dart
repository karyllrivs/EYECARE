import 'package:eyecare_mobile/model/cart.model.dart';
import 'package:eyecare_mobile/model/product.model.dart';
import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsBottomNavBar extends StatelessWidget {
  const ProductDetailsBottomNavBar({
    super.key,
    required this.mediaQuerySize,
    required this.product,
    required this.theme,
  });

  final Size mediaQuerySize;
  final Product? product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQuerySize.width,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showResultDialog(context, true,
                    message: "${product!.name} is added to cart.");

                context.read<CartViewModel>().addCartItem(
                      Cart(
                        productId: product!.id,
                        name: product!.name,
                        image: product!.image,
                        price: product!.price,
                        quantity: 1,
                      ),
                    );
              },
              child: Container(
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(167, 144, 131, 1),
                  border: Border.all(color: theme.colorScheme.onPrimary),
                ),
                child: Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.8),
                  border: Border.all(color: theme.colorScheme.onPrimary),
                ),
                child: Center(
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
