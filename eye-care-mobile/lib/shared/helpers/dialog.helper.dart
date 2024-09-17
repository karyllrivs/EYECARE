import 'package:eyecare_mobile/shared/widgets/dialog.dart';
import 'package:flutter/material.dart';

void showResultDialog(BuildContext context, bool success,
    {String? message, String? buttonText, Function? callback}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return DialogWidget(
        icon: Icon(
          (success ? Icons.check : Icons.error),
          color: success ? Colors.green : Theme.of(context).colorScheme.error,
          size: 48,
        ),
        title: success ? 'Success' : 'Error',
        body: message ?? '',
        buttonText: buttonText ?? "OK",
      );
    },
  ).then((_) {
    callback!();
  });
}
