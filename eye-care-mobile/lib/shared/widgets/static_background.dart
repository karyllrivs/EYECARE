import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StaticBackground extends StatefulWidget {
  final bool showBackground;
  final Widget body;

  const StaticBackground({
    super.key,
    required this.body,
    this.showBackground = false,
  });

  @override
  State<StaticBackground> createState() => _StaticBackground();
}

class _StaticBackground extends State<StaticBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(),
        if (widget.showBackground)
          SvgPicture.asset(
            'assets/images/background_accent.svg',
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        widget.body
      ],
    );
  }
}
