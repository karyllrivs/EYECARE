import 'package:eyecare_mobile/enums/order_status.dart';
import 'package:eyecare_mobile/model/order.model.dart';
import 'package:eyecare_mobile/pages/rating/add_rating.dart';
import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/view_model/order.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistory();
}

class _OrderHistory extends State<OrderHistory> {
  List<Order> orders = [];

  @override
  void initState() {
    context.read<OrderViewModel>().fetchOrders();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    orders = context.watch<OrderViewModel>().orders;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: const Nav(title: "Order History", isAuth: true),
      bottomNavigationBar: const BottomNavbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (_, index) {
            Order order = orders[index];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: const Icon(
                              Icons.storefront,
                            ),
                            title: Text(
                              "Delivered on ${order.deliveredOn}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: themeData.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red[300]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 100,
                          child: Text(
                            order.id,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red[300]!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: themeData.colorScheme.onPrimary,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Image.network(
                                getFilePath(order.image),
                              ),
                            ),
                            Icon(
                              Icons.close,
                              size: 15,
                              color: themeData.colorScheme.onPrimary,
                            ),
                            Text(
                              order.quantity.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: themeData.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "₱${order.total}",
                          style: TextStyle(
                            fontSize: 20,
                            color: themeData.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: themeData.colorScheme.onPrimary,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: order.status == OrderStatus.confirmed.name
                                  ? themeData.colorScheme.primary
                                  : order.status == OrderStatus.canceled.name
                                      ? Colors.red
                                      : order.status ==
                                              OrderStatus.delivered.name
                                          ? Colors.green
                                          : Colors.yellow,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            order.status,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: order.status == OrderStatus.confirmed.name
                                  ? themeData.colorScheme.primary
                                  : order.status == OrderStatus.canceled.name
                                      ? Colors.red
                                      : order.status ==
                                              OrderStatus.delivered.name
                                          ? Colors.green
                                          : Colors.yellow,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddRating(
                                  productId: order.productId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: themeData.colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.note_alt_outlined,
                                    color: themeData.colorScheme.surface,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Add review",
                                    style: TextStyle(
                                      color: themeData.colorScheme.surface,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
