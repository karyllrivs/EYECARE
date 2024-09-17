import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/shared/widgets/terms_disclaimer.dart';
import 'package:flutter/material.dart';

// ADDED
import 'package:eyecare_mobile/model/auth.model.dart';
import 'package:eyecare_mobile/view_model/auth.view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthSignup extends StatefulWidget {
  const AuthSignup({super.key});

  @override
  State<AuthSignup> createState() => _AuthSignup();
}

class _AuthSignup extends State<AuthSignup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final Map<String, String?> _signupForm = {
    "firstName": null,
    "lastName": null,
    "email": null,
    "password": null,
  };

  void signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // updates _signupForm with values from TextFormFields

      try {
        final newUser = Auth(
            id: "",
            firstName: _signupForm['firstName']!,
            lastName: _signupForm['lastName']!,
            email: _signupForm['email']!,
            password: _signupForm['password']!);

        String message =
            await context.read<AuthViewModel>().signupUser(newUser);
        if (mounted) {
          showResultDialog(context, true, message: message, callback: () {
            context.go("/verify-account");
          });
        }
      } catch (e) {
        if (mounted) showResultDialog(context, false, message: e.toString());
      }
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(
        title: "Sign Up",
      ),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              child: Image.asset(
                'assets/images/eyecare_logo.png',
                alignment: Alignment.center,
                height: 120,
              ),
            ),

            // LOGIN FORM
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Column(
                  children: <Widget>[
                    // first name
                    TextFormField(
                      validator: (value) => firstNameValidator(value),
                      decoration: getInputDecorator(context, "First Name"),
                      style: getInputStyle(context),
                      onSaved: (value) => {_signupForm['firstName'] = value},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // last name
                    TextFormField(
                      validator: (value) => lastNameValidator(value),
                      decoration: getInputDecorator(context, "Last Name"),
                      style: getInputStyle(context),
                      onSaved: (value) => {_signupForm['lastName'] = value},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // email
                    TextFormField(
                      validator: (value) => emailValidator(value),
                      decoration: getInputDecorator(context, "Email"),
                      style: getInputStyle(context),
                      onSaved: (value) => {_signupForm['email'] = value},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // password
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) => passwordValidator(value),
                      decoration: getInputDecorator(context, "Password"),
                      style: getInputStyle(context),
                      onSaved: (value) => {_signupForm['password'] = value},
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // repeat password
                    TextFormField(
                      validator: (value) => repeatPasswordValidator(
                          value, _passwordController.text),
                      decoration: getInputDecorator(context, "Repeat Password"),
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
              backgroundColor: Colors.green,
              isPrimary: true,
              text: "CREATE ACCOUNT",
              onPressed: () => signup(),
            ),
          ],
        ),
      ),
    );
  }
}
