import 'package:flutter/material.dart';

class Nav extends StatefulWidget implements PreferredSizeWidget {
  final bool implyLeading;
  final String title;
  final bool isAuth;
  final GlobalKey<ScaffoldState>? scaffoldKey; // for seperate drawer control

  const Nav({
    super.key,
    this.implyLeading = true,
    this.title = '',
    this.isAuth = false,
    this.scaffoldKey,
  });

  @override
  State<Nav> createState() => _Nav();

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}

class _Nav extends State<Nav> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.implyLeading,
      backgroundColor: widget.isAuth
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.primary,
      elevation: 5,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: widget.isAuth
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.surface, //change your color here
      ),
      title: Text(
        widget.title,
        style: TextStyle(
            color: widget.isAuth
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.surface,
            fontSize: 17,
            fontWeight: FontWeight.bold),
      ),
      // actions: widget.isAuth
      //     ? [
      //         const AuthNav(),
      //       ]
      //     : null,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AuthNav extends StatefulWidget {
  const AuthNav({super.key});

  @override
  State<AuthNav> createState() => _AuthNav();
}

class _AuthNav extends State<AuthNav> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 27,
        ),
        const SizedBox(
          width: 20,
        ),
        Icon(
          Icons.shopping_cart_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 27,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
