import 'package:eyecare_mobile/model/product.model.dart';
import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        context.push("/product_details", extra: product.id);
      },
      child: Container(
        width: screenWidth * 0.3,
        height: screenWidth * 0.3,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      getFilePath(product.image),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.primary,
              ),
            ),
            Text(
              "₱${product.price}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
