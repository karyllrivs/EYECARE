import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/account_verification.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountVerification extends StatefulWidget {
  const AccountVerification({super.key});

  @override
  State<AccountVerification> createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tokenController = TextEditingController();
  final Map<String, String?> _accountVerificationForm = {
    "token": null,
  };

  Future<void> sendVerificationToken() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // updates _accountVerificationForm with values from TextFormFields

      try {
        AccountVerificationViewModel accountVerificationViewModel =
            AccountVerificationViewModel();
        String message = await accountVerificationViewModel
            .sendAccountVerificationToken(_accountVerificationForm["token"]);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(
        title: "Account Verification",
      ),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            Column(
              children: [
                Text(
                  "Verify your Account.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const Text(
                  "Please insert the token sent on your email and verify your account.",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            // ACCOUNT VERIFICATION FORM
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 70),
                child: Column(
                  children: <Widget>[
                    // token
                    TextFormField(
                      controller: _tokenController,
                      onSaved: (value) =>
                          _accountVerificationForm['token'] = value,
                      validator: (value) => requiredValidator(value),
                      decoration: getInputDecorator(context, "Token"),
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
              onPressed: () => sendVerificationToken(),
            ),
          ],
        ),
      ),
    );
  }
}
