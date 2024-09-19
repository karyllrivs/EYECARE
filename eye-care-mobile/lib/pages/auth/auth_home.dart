import 'package:eyecare_mobile/pages/auth/auth_login.dart';
import 'package:eyecare_mobile/pages/auth/auth_signup.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:flutter/material.dart';

class AuthHome extends StatefulWidget {
  const AuthHome({super.key});

  @override
  State<AuthHome> createState() => _AuthHome();
}

class _AuthHome extends State<AuthHome> {
  void goTo(String page) {
    switch (page) {
      case 'signup':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthSignup(),
            ));
        break;
      case 'login':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthLogin(),
            ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaticBackground(
        body: ScrollableContainer(
          paddingSize: 'narrow',
          children: [
            Image.asset(
              'assets/images/eyecare_logo.png',
              alignment: Alignment.center,
              height: 200,
            ),
            const SizedBox(
              height: 54,
            ),
            Button(
              backgroundColor: Theme.of(context).colorScheme.primary,
              isPrimary: true,
              text: "LOGIN",
              onPressed: () => goTo('login'),
            ),
            const SizedBox(
              height: 24,
            ),
            Button(
              backgroundColor: Colors.green,
              isPrimary: true,
              text: "CREATE ACCOUNT",
              onPressed: () => goTo('signup'),
            ),
          ],
        ),
      ),
    );
  }
}
