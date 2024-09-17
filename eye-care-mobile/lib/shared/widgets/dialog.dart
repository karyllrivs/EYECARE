import 'package:eyecare_mobile/shared/styles/style_getters.dart';
import 'package:eyecare_mobile/shared/widgets/button.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final Icon? icon;
  final String title;
  final String body;
  final String buttonText;

  const DialogWidget(
      {super.key,
      this.icon,
      required this.title,
      required this.body,
      this.buttonText = 'OK'});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: Text(
        title,
        style: getDialogTextStyle(context),
      ),
      content: Text(
        body,
        style: getDialogTextStyle(context),
        textAlign: TextAlign.center,
      ),
      actions: [
        Button(
          text: buttonText,
          onPressed: () => Navigator.pop(context),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowDirection: VerticalDirection.down,
      actionsOverflowButtonSpacing: 16,
    );
  }
}
