import 'package:eyecare_mobile/model/product.model.dart';
import 'package:eyecare_mobile/shared/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ShopProductList extends StatefulWidget {
  final List<Product> products;
  const ShopProductList({super.key, required this.products});

  @override
  State<ShopProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ShopProductList> {
  bool isViewAll = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Products",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        GridView.builder(
          itemCount: widget.products.length,
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final product = widget.products[index];
            return ProductItem(product: product);
          },
        ),
      ],
    );
  }
}
