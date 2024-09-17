import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductDetailsAppBar({
    super.key,
    required this.theme,
    required this.cartCount,
    this.height = kToolbarHeight,
    required this.productId,
  });

  final ThemeData theme;
  final int cartCount;
  final double height;
  final String productId;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: ElevatedButton(
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(color: theme.colorScheme.onPrimary),
          ),
        ),
        onPressed: () {
          context.push("/virtual", extra: productId);
        },
        child: Text(
          "Virtual Try-On",
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
      ),
      centerTitle: true,
      actions: [
        cartCount > 0
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: Badge(
                  label: Text("$cartCount"),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.push('/cart');
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.push('/cart');
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
      ],
    );
  }
}
