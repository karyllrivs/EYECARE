import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:eyecare_mobile/view_model/product.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({super.key, this.height = kToolbarHeight});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int cartCount = 0;

  final TextEditingController _keywordController = TextEditingController();

  void searchProduct() {
    if (_keywordController.text != "") {
      context
          .read<ProductViewModel>()
          .fetchProductsByKeyword(_keywordController.text);

      context.go("/product-search");
    }
  }

  @override
  void didChangeDependencies() {
    cartCount = context.watch<CartViewModel>().getCartCount();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: TextField(
          controller: _keywordController,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: 'Search'),
        ),
      ),
      actions: [
        IconButton(
          onPressed: searchProduct,
          icon: const Icon(Icons.search_outlined),
        ),
        cartCount > 0
            ? Badge(
                label: Text("$cartCount"),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context.push('/cart');
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.push('/cart');
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
        Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: const Icon(Icons.menu_outlined),
          ),
        ),
      ],
    );
  }
}
