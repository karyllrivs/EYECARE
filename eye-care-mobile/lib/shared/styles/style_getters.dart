import 'package:flutter/material.dart';

BoxDecoration getElevatedContainerDecoration(BuildContext context,
    {Color? bgColor, bool hasShadow = true}) {
  return BoxDecoration(
      color: bgColor ?? Theme.of(context).colorScheme.surface,
      boxShadow: hasShadow
          ? [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ]
          : null,
      border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
      borderRadius: const BorderRadius.all(Radius.circular(8)));
}

InputDecoration getInputDecorator(BuildContext context, String labelText,
    {bool onBlue = false, IconButton? suffixIcon}) {
  return InputDecoration(
    // hintText: 'What do people call you?',
    labelText: labelText,
    labelStyle: const TextStyle(
      fontSize: 13,
    ),
    floatingLabelStyle: const TextStyle(
      fontSize: 16,
    ),
    fillColor: Colors.white,
    filled: true,
    errorMaxLines: 4,
    border: onBlue ? null : const OutlineInputBorder(),
    suffixIcon: suffixIcon,
    iconColor: Theme.of(context).colorScheme.primary,
  );
}

InputDecorationTheme getInputDecoratorTheme(BuildContext context,
    {bool onBlue = false, IconButton? suffixIcon}) {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.all(8),
    labelStyle: const TextStyle(
      fontSize: 13,
    ),
    floatingLabelStyle: const TextStyle(
      fontSize: 16,
    ),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    fillColor: Colors.white,
    filled: true,
    errorMaxLines: 4,
    border: onBlue ? null : const OutlineInputBorder(),
    suffixIconColor: Theme.of(context).colorScheme.primary,
  );
}

TextStyle getInputStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle getDialogTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle getTitleStyle(BuildContext context, {bool onBlue = false}) {
  return TextStyle(
    color: onBlue
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    shadows: onBlue
        ? [
            Shadow(
                offset: const Offset(2, 2),
                blurRadius: 5.0,
                color: Theme.of(context).colorScheme.primary),
          ]
        : null,
  );
}

// LIST TILES
TextStyle getLTTitleStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );
}

TextStyle getLTSubitleStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.onSurface,
    fontSize: 12,
  );
}

// DROPDOWN

TextStyle getDDOptionStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.normal,
  );
}
