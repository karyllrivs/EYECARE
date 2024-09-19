import 'package:eyecare_mobile/pages/shop/shop_product_list.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/custom_app_bar.dart';
import 'package:eyecare_mobile/shared/widgets/end_drawer.dart';
import 'package:eyecare_mobile/view_model/product.view_model.dart';
import 'package:flutter/material.dart';
import 'package:eyecare_mobile/model/product.model.dart';
import 'package:provider/provider.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  List<Product> searchProducts = [];

  @override
  void didChangeDependencies() {
    searchProducts = context.watch<ProductViewModel>().searchProducts;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const BottomNavbar(),
      endDrawer: const EndDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: searchProducts.isEmpty
            ? const Center(
                child: Text("No data found."),
              )
            : SingleChildScrollView(
                child: ShopProductList(products: searchProducts),
              ),
      ),
    );
  }
}
