import 'package:flutter/material.dart';

class ColorScheme1 extends ColorScheme {
  const ColorScheme1({
    // Define your custom colors here
    // https://jonas-rodehorst.dev/tools/flutter-color-from-hex
    Color primary = const Color(0xff3d93f8),
    Color secondary = const Color(0xff00c0ff),
    Color error = const Color(0xffea4335),
    Color white = Colors.white,
    Color black = const Color(0xff212121),
    Color grey = const Color(0xff8f959e),
  }) : super(
          primary: primary,
          onPrimary: black,
          secondary: secondary,
          onSecondary: black,
          brightness: Brightness.light,
          error: error,
          onError: white,
          surface: white,
          onSurface: grey,
        );
}
