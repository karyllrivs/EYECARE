import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/shared/widgets/scrollable_container.dart';
import 'package:eyecare_mobile/shared/widgets/static_background.dart';
import 'package:eyecare_mobile/view_model/cart.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VerifyPayment extends StatefulWidget {
  const VerifyPayment({super.key});

  @override
  State<VerifyPayment> createState() => _VerifyPaymentState();
}

class _VerifyPaymentState extends State<VerifyPayment> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final Map<String, String?> _verifyPaymentForm = {
    "otp": null,
  };

  Future<void> verifyPayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // updates _verifyPaymentForm with values from TextFormFields

      try {
        CartViewModel cartViewModel = CartViewModel();
        String message =
            await cartViewModel.verifyPayment(_verifyPaymentForm["otp"]);

        if (mounted) {
          showResultDialog(context, true, message: message, callback: () {
            context.read<CartViewModel>().getIsPaymentVerified();
            context.pop();
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
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Nav(
        title: "Verify Payment",
      ),
      body: StaticBackground(
        body: ScrollableContainer(
          children: [
            Column(
              children: [
                Text(
                  "Please insert your OTP to verify the payment.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const Text(
                  "Check your email to get the OTP.",
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
                      controller: _otpController,
                      onSaved: (value) => _verifyPaymentForm['otp'] = value,
                      validator: (value) => requiredValidator(value),
                      decoration: getInputDecorator(context, "OTP"),
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
              onPressed: () => verifyPayment(),
            ),
          ],
        ),
      ),
    );
  }
}
