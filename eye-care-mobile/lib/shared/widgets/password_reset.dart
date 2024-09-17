import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/password_reset.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final Map<String, String?> _passwordResetForm = {
    "email": null,
  };

  Future<void> sendEmail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // updates _passwordResetForm with values from TextFormFields

      try {
        PasswordResetViewModel passwordResetViewModel =
            PasswordResetViewModel();
        String message = await passwordResetViewModel
            .createTokenForPasswordReset(_passwordResetForm["email"]);

        if (mounted) {
          showResultDialog(context, true, message: message, callback: () {
            context.push("/password-token");
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
    _emailController.dispose();
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
                  "Please insert your email to reset your password.",
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
                    // email
                    TextFormField(
                      controller: _emailController,
                      onSaved: (value) => _passwordResetForm['email'] = value,
                      validator: (value) => emailValidator(value),
                      decoration: getInputDecorator(context, "Email"),
                      style: getInputStyle(context),
                    ),
                  ],
                ),
              ),
            ),

            Button(
              backgroundColor: Theme.of(context).colorScheme.primary,
              isPrimary: true,
              text: "Submit",
              onPressed: () => sendEmail(),
            ),
          ],
        ),
      ),
    );
  }
}
