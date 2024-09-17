import 'package:eyecare_mobile/model/product.model.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/custom_app_bar.dart';
import 'package:eyecare_mobile/shared/widgets/end_drawer.dart';
import 'package:eyecare_mobile/shared/widgets/product_item.dart';
import 'package:eyecare_mobile/view_model/product.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryProducts extends StatefulWidget {
  final String categoryId;
  const CategoryProducts({super.key, required this.categoryId});

  @override
  State<CategoryProducts> createState() => _CategoryProducts();
}

class _CategoryProducts extends State<CategoryProducts> {
  List<Product> products = [];
  String categoryName = "";

  void loadProducts() {
    products = context.read<ProductViewModel>().products;
    products = products
        .where((product) => product.categoryId == widget.categoryId)
        .toList();

    categoryName = products.isNotEmpty
        ? products[0].categoryName
        : "No product on the selected category.";
  }

  @override
  void didChangeDependencies() {
    loadProducts();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const EndDrawer(),
      bottomNavigationBar: const BottomNavbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      categoryName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
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
                itemCount: products.length,
                shrinkWrap: true,
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(product: product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
