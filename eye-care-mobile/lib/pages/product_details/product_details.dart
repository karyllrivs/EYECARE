import 'package:eyecare_mobile/model/product.model.dart';
import 'package:eyecare_mobile/pages/product_details/product_details_app_bar.dart';
import 'package:eyecare_mobile/pages/product_details/product_details_bottom_nav_bar.dart';
import 'package:eyecare_mobile/pages/product_details/product_variants.dart';
import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';
import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:eyecare_mobile/view_model/product.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product? product;
  int cartCount = 0;

  @override
  void didChangeDependencies() {
    product = product ??
        context.watch<ProductViewModel>().fetchProduct(widget.productId);
    cartCount = context.watch<CartViewModel>().getCartCount();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ProductDetailsAppBar(
        theme: theme,
        cartCount: cartCount,
        productId: product!.id,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: mediaQuerySize.height * 0.3,
                width: mediaQuerySize.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                child: Image.network(
                  getFilePath(product!.image),
                ),
              ),
              SizedBox(
                height: mediaQuerySize.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product!.categoryName),
                      SizedBox(
                        width: mediaQuerySize.width * 0.7,
                        child: Text(
                          product!.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Price"),
                      Text(
                        "₱${product!.price}",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ProductVariants(
                mediaQuerySize: mediaQuerySize,
                productImages:
                    List.generate(8, (_) => product!.image), //Sample data
              ),
              Center(
                child: SizedBox(
                  width: mediaQuerySize.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ReadMoreText(
                        product!.description,
                        trimMode: TrimMode.Length,
                        trimLength: 200,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: ' Show less',
                        lessStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                        moreStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuerySize.height * 0.02,
              ),
              SizedBox(
                width: mediaQuerySize.width,
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.chevron_right_outlined,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuerySize.height * 0.02,
              ),
              SizedBox(
                width: mediaQuerySize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "with VAT, SD",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "₱${product!.price}",
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductDetailsBottomNavBar(
          mediaQuerySize: mediaQuerySize, product: product, theme: theme),
    );
  }
}
