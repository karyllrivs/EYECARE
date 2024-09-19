import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/brand_list.dart';
import 'package:eyecare_mobile/shared/widgets/custom_app_bar.dart';
import 'package:eyecare_mobile/shared/widgets/custom_carousel.dart';
import 'package:eyecare_mobile/shared/widgets/end_drawer.dart';
import 'package:eyecare_mobile/pages/home/home_product_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      endDrawer: EndDrawer(),
      bottomNavigationBar: BottomNavbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Column(
            children: [
              CustomCarousel(),
              SizedBox(
                height: 10,
              ),
              BrandList(),
              SizedBox(
                height: 10,
              ),
              HomeProductList(),
            ],
          ),
        ),
      ),
    );
  }
}
