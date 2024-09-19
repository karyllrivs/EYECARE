import 'package:eyecare_mobile/model/auth.model.dart';
import 'package:eyecare_mobile/pages/consultation/consultation_history.dart';
import 'package:eyecare_mobile/pages/profile/profile_edit.dart';
import 'package:eyecare_mobile/pages/order/order_history.dart';
import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  late final List<Map<String, dynamic>> menu = [
    {
      "leading": Icons.person_2_outlined,
      "title": "Edit Profile",
      "subtitle": "Make changes to your account",
      "callback": null,
      "navigateTo": const ProfileEdit(),
    },
    {
      "leading": Icons.shopping_cart_outlined,
      "title": "Order History",
      "subtitle": "View your Order History",
      "callback": null,
      "navigateTo": const OrderHistory(),
    },
    {
      "leading": Icons.list_alt_outlined,
      "title": "Consultation History",
      "subtitle": "View your Consultation History",
      "callback": null,
      "navigateTo": const ConsultationHistory(),
    },
    {
      "leading": Icons.logout_outlined,
      "title": "Log out",
      "subtitle": "Further secure your account for safety",
      "callback": logout,
      "navigateTo": null,
    },
  ];

  Future<void> logout() async {
    await context.read<AuthViewModel>().logoutUser();
  }

  Auth? currentUser;
  String fullname = "";
  String profileAvatarLink = "";

  @override
  void didChangeDependencies() {
    currentUser = context.watch<AuthViewModel>().authenticatedUser!;
    fullname = "${currentUser!.firstName} ${currentUser!.lastName}";
    profileAvatarLink = currentUser!.image != null
        ? getFilePath(
            "${context.read<AuthViewModel>().authenticatedUser!.image}")
        : "https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(title: "Profile", isAuth: true),
      bottomNavigationBar: const BottomNavbar(),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            CircleAvatar(
              radius: 50.0,
              child: Image.network(profileAvatarLink),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 30),
              child: Column(
                children: [
                  Text(
                    fullname,
                    style: getTitleStyle(context),
                  ),
                  Text(
                    currentUser!.email,
                  ),
                ],
              ),
            ),
            Container(
              decoration: getElevatedContainerDecoration(context),
              child: ListView.builder(
                padding: const EdgeInsets.all(5),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(menu[index]['leading']),
                    title: Text(
                      menu[index]['title'],
                      style: getLTTitleStyle(context),
                    ),
                    subtitle: Text(
                      menu[index]['subtitle'],
                      style: getLTSubitleStyle(context),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Run callback if any
                      if (menu[index]['callback'] != null) {
                        menu[index]['callback']();
                      }

                      if (menu[index]['navigateTo'] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => menu[index]['navigateTo'],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
