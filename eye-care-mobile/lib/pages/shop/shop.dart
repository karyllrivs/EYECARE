import 'package:eyecare_mobile/pages/shop/shop_product_list.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/custom_app_bar.dart';
import 'package:eyecare_mobile/shared/widgets/end_drawer.dart';
import 'package:flutter/material.dart';
import 'package:eyecare_mobile/model/product.model.dart';
import 'package:eyecare_mobile/view_model/product.view_model.dart';
import 'package:provider/provider.dart';

class Shop extends StatefulWidget {
  final String? categoryId;
  const Shop({super.key, this.categoryId});

  @override
  State<Shop> createState() => _Shop();
}

class _Shop extends State<Shop> {
  List<Product> products = [];

  @override
  void didChangeDependencies() {
    products = context.watch<ProductViewModel>().products;
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
        child: SingleChildScrollView(
          child: ShopProductList(
            products: products,
          ),
        ),
      ),
    );
  }
}
