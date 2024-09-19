import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';
import 'package:flutter/material.dart';

class ProductVariants extends StatelessWidget {
  const ProductVariants({
    super.key,
    required this.mediaQuerySize,
    required this.productImages,
  });

  final Size mediaQuerySize;
  final List<String> productImages;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 10,
        runAlignment: WrapAlignment.start,
        children: List.generate(
          productImages.length,
          (index) => SizedBox(
            width: mediaQuerySize.height * 0.1,
            height: mediaQuerySize.height * 0.1,
            child: Image.network(getFilePath(productImages[index])),
          ),
        ),
      ),
    );
  }
}
