import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  "https://static.zennioptical.com/marketing/landingpage/readers24/round2/Readers_lp_ways_to_shop-lg.png",
  "https://t3.ftcdn.net/jpg/02/72/20/24/360_F_272202455_3c7x498VbHDkOjWf6FdVHG2OxS6wwe5p.jpg",
  "https://i.ebayimg.com/images/g/7lwAAOSwkVBf9z1C/s-l1200.webp"
];

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarousel();
}

class _CustomCarousel extends State<CustomCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<Widget> imageSliders = imgList
      .map((item) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: double.infinity,
      height: mediaQuery.size.height * 0.4,
      child: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
