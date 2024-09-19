import 'package:flutter/material.dart';

class ScrollableContainer extends StatefulWidget {
  final List<Widget> children;
  final String paddingSize; // 'wide' | 'narrow'

  const ScrollableContainer(
      {super.key, required this.children, this.paddingSize = 'wide'});

  @override
  State<ScrollableContainer> createState() => _ScrollableContainer();
}

class _ScrollableContainer extends State<ScrollableContainer> {
  final Map<String, double> padding = {
    "wide": 20,
    "narrow": 40,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(padding[widget.paddingSize]!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: widget.children,
        ),
      ),
    );
  }
}
