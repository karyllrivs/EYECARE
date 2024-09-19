import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Color backgroundColor;
  final String text;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const Button(
      {super.key,
      this.backgroundColor = Colors.white,
      this.text = "Text",
      this.isPrimary = false,
      this.onPressed});

  @override
  State<Button> createState() => _Button();
}

class _Button extends State<Button> {
  final shape = WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(5),
        backgroundColor: WidgetStateProperty.all<Color>(
          widget.backgroundColor,
        ),
        shape: shape,
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(width: 1, color: Theme.of(context).colorScheme.onPrimary),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(20),
        ),
        shadowColor:
            WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
        splashFactory: InkRipple.splashFactory,
        animationDuration: const Duration(milliseconds: 1000),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
            color: widget.isPrimary
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 16),
      ),
    );
  }
}
