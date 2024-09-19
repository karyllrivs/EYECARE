import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbar();
}

class _BottomNavbar extends State<BottomNavbar> {
  late int currentIndex = 0;

  late String currentRoute = context
      .read<AuthViewModel>()
      .routerConfig
      .routeInformationProvider
      .value
      .uri
      .toString();

  void goToPage(int index) {
    switch (index) {
      case 0:
        context.go('/');
      case 1:
        context.go('/shop');
      case 2:
        context.go('/consultation');
      case 3:
        context.go('/profile');
    }

    setCurrentIndex();
  }

  void setCurrentIndex() {
    switch (currentRoute) {
      case "/":
        currentIndex = 0;
        break;
      case "/shop":
      case "/category":
        currentIndex = 1;
        break;
      case "/consultation":
        currentIndex = 2;
        break;
      case "/profile":
        currentIndex = 3;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    setCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "",
        ),
      ],
      selectedFontSize: 0,
      unselectedFontSize: 0,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      onTap: goToPage,
    );
  }
}
