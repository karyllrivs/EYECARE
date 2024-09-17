import 'package:flutter/material.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  List<Map<String, dynamic>> brands = [
    {
      "name": "Giordano",
      "image":
          "https://www.dpmallsemarang.com/wp-content/uploads/2019/07/giordano.jpg",
    },
    {
      "name": "Stepper",
      "image":
          "https://iconape.com/wp-content/png_logo_vector/stepper-logo.png",
    },
    {
      "name": "Parim",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsj4J6Ss8l28NfXRgdei3OnxcQpFMytvby2A&s",
    },
    {
      "name": "Jill stuart",
      "image":
          "https://cdn.shopify.com/s/files/1/0433/5013/0841/files/JILLSTUART_Eyewear_Logo_300px.png",
    },
    {
      "name": "Hangten",
      "image":
          "https://cdn.shopify.com/s/files/1/0258/6132/4905/files/hangten_mark.png",
    },
    {
      "name": "Dazzle",
      "image":
          "https://assets.sandsresortsmacao.cn/content/venetianmacao/shopping/shoppes/fashion-women/dazzle/dazzle_500x455.jpg",
    },
    {
      "name": "Imax",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ61X93EQv724Syy1DLXQKMo1E8CkqS8Zjsag&s",
    },
    {
      "name": "Dream himax",
      "image":
          "https://trademarks.justia.com/media/og_image.php?serial=85427892",
    },
    {
      "name": "FFF",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcaudPW8ZxNoKAZeilgEPVc5cxNdxdsNR6EA&s",
    },
    {
      "name": "Euphoria",
      "image":
          "https://euphoriabrand.fr/cdn/shop/files/logo-euphoria-brand-official.png",
    },
    {
      "name": "Instyle",
      "image":
          "https://www.pikpng.com/pngl/m/451-4513033_in-style-magazine-logo-instyle-magazine-vector-logo.png",
    },
    {
      "name": "Neostyle",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTK9sS8AkAR-eLBNEAcZ-G7ae6accMaLLRuA&s",
    },
    {
      "name": "Velocity",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPlgu-o4h7fLvFW_gSH_T9i6HWxdLrc0vpFg&s",
    },
    {
      "name": "Swissplus",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSN013EB7BpWIQFDcvRFswfS08kaCsFewi5_g&s",
    },
    {
      "name": "Suncari",
      "image":
          "https://down-ph.img.susercontent.com/file/e0fdcebe5b4a27c4a640f4fd964003a7_tn",
    },
    {
      "name": "Charmant Z",
      "image":
          "https://static.wixstatic.com/media/1e07ee_5076d023626c45de91beed4877c4921d~mv2.png",
    },
    {
      "name": "Urban",
      "image": "https://www.tuscanyeyewear.com/Images/client/urban-eyewear.png",
    },
    {
      "name": "Sephora",
      "image":
          "https://logos-world.net/wp-content/uploads/2022/02/Sephora-Symbol.png",
    },
    {
      "name": "Optelli",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDpiNqyTB4dDizqWhtF29SxZ7QyuH2JCbfJA&s",
    },
    {
      "name": "Minima",
      "image":
          "https://schelfhoutoogenoor.nl/wp-content/uploads/2021/08/Minima-eyewear.png",
    },
  ];

  bool isViewAll = false;

  void toggleViewAll() {
    isViewAll = !isViewAll;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Brands",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary),
              ),
              InkWell(
                onTap: toggleViewAll,
                child: Text(
                  isViewAll ? "View Less" : "View All",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            child: SingleChildScrollView(
              scrollDirection: isViewAll ? Axis.vertical : Axis.horizontal,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: List.generate(brands.length, (int index) {
                  final brand = brands[index];
                  return Container(
                    width: mediaQuery.size.width * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.onSecondary),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.colorScheme.onSecondary,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(brand["image"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            brand["name"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
