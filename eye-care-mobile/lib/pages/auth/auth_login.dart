import 'package:eyecare_mobile/model/auth.model.dart';
import 'package:eyecare_mobile/services/firebase_auth.services.dart';
import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/shared/widgets/terms_disclaimer.dart';
import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLogin();
}

class _AuthLogin extends State<AuthLogin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Map<String, String?> _loginForm = {
    "email": null,
    "password": null,
  };

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // updates _signupForm with values from TextFormFields
      try {
        final loginCredentials = Auth(
            id: "",
            email: _loginForm['email']!,
            password: _loginForm['password']!);

        dynamic result =
            await context.read<AuthViewModel>().loginUser(loginCredentials);

        if (result != null && mounted) {
          showResultDialog(context, false, message: result, callback: () {
            context.go("/verify-account");
          });
        }
      } catch (e) {
        if (mounted) showResultDialog(context, false, message: e.toString());
      }
    }
  }

  void googleLogin() async {
    try {
      FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
      final user = await firebaseAuthServices.loginWithGoogle();
      if (user == null) {
        throw Exception("Failed to login.");
      }

      if (mounted) {
        await context.read<AuthViewModel>().googleLoginUser(user.email!);
      }
    } catch (e, stacktrace) {
      debugPrintStack(stackTrace: stacktrace, label: "SERVER");
      if (mounted) showResultDialog(context, false, message: e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(
        title: "Login",
      ),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            Column(
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                const Text(
                  "Please enter your data to continue",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            // LOGIN FORM
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 70),
                child: Column(
                  children: <Widget>[
                    // email
                    TextFormField(
                      controller: _emailController,
                      onSaved: (value) => _loginForm['email'] = value,
                      validator: (value) => emailValidator(value),
                      decoration: getInputDecorator(context, "Email"),
                      style: getInputStyle(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // password
                    TextFormField(
                      controller: _passwordController,
                      onSaved: (value) => _loginForm['password'] = value,
                      decoration: getInputDecorator(context, "Password"),
                      style: getInputStyle(context),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),

            // TERMS AND CONDITIONS
            const TermsDisclaimer(),
            const SizedBox(
              height: 24,
            ),

            Button(
              backgroundColor: Theme.of(context).colorScheme.primary,
              isPrimary: true,
              text: "LOGIN",
              onPressed: () => login(),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "or",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SignInButton(Buttons.google, onPressed: googleLogin),
            const SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: () {
                context.push("/password-reset");
              },
              child: const Text(
                "Forgot Password?",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
