import 'package:eyecare_mobile/model/product.model.dart';
import 'package:eyecare_mobile/shared/widgets/product_item.dart';
import 'package:eyecare_mobile/view_model/product.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeProductList extends StatefulWidget {
  const HomeProductList({super.key});

  @override
  State<HomeProductList> createState() => _ProductListState();
}

class _ProductListState extends State<HomeProductList> {
  bool isViewAll = false;

  List<Product> products = [];
  List<Product> filteredProducts = [];

  @override
  void didChangeDependencies() {
    products = context.watch<ProductViewModel>().products;
    filteredProducts = [...products.sublist(0, (products.length / 2).ceil())];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Products",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary),
            ),
            InkWell(
              onTap: () {
                context.go('/shop');
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 12.0,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        GridView.builder(
          itemCount: filteredProducts.length,
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return ProductItem(product: product);
          },
        ),
      ],
    );
  }
}
