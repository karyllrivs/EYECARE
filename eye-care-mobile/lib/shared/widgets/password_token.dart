import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/password_token.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordToken extends StatefulWidget {
  const PasswordToken({super.key});

  @override
  State<PasswordToken> createState() => _PasswordTokenState();
}

class _PasswordTokenState extends State<PasswordToken> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final Map<String, String?> _resetTokenForm = {
    "token": null,
    "password": null,
    "confirmPassword": null,
  };

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // updates _resetTokenForm with values from TextFormFields
      try {
        PasswordTokenViewModel passwordTokenViewModel =
            PasswordTokenViewModel();
        String message =
            await passwordTokenViewModel.confirmTokenForPasswordReset(
          _resetTokenForm["token"],
          _resetTokenForm["password"],
          _resetTokenForm["confirmPassword"],
        );

        if (mounted) {
          showResultDialog(context, true, message: message, callback: () {
            context.go("/login");
          });
        }
      } catch (e) {
        if (mounted) showResultDialog(context, false, message: e.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(
        title: "Forgot Password",
      ),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            Column(
              children: [
                Text(
                  "Reset Your Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const Text(
                  "Please insert the token sent on your email and your new password.",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            // PASSWORD RESET FORM
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 70),
                child: Column(
                  children: <Widget>[
                    // token
                    TextFormField(
                      controller: _tokenController,
                      onSaved: (value) => _resetTokenForm['token'] = value,
                      validator: (value) => requiredValidator(value),
                      decoration: getInputDecorator(context, "Token"),
                      style: getInputStyle(context),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // token
                    TextFormField(
                      controller: _passwordController,
                      onSaved: (value) => _resetTokenForm['password'] = value,
                      validator: (value) => passwordValidator(value),
                      decoration: getInputDecorator(context, "Password"),
                      style: getInputStyle(context),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // token
                    TextFormField(
                      controller: _confirmPasswordController,
                      onSaved: (value) =>
                          _resetTokenForm['confirmPassword'] = value,
                      validator: (value) => repeatPasswordValidator(
                          value, _passwordController.text),
                      decoration:
                          getInputDecorator(context, "Confirm Password"),
                      style: getInputStyle(context),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),

            Button(
              backgroundColor: Theme.of(context).colorScheme.primary,
              isPrimary: true,
              text: "Submit",
              onPressed: () => resetPassword(),
            ),
          ],
        ),
      ),
    );
  }
}
