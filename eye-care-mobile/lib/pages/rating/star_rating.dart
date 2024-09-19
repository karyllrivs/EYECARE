import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int starCount;
  final int rating;
  final Function(int) onRatingChanged;

  const StarRating({
    super.key,
    this.starCount = 5,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(widget.starCount, (index) {
        return IconButton(
          icon: Icon(
            index < widget.rating ? Icons.star : Icons.star_border,
            color: index < widget.rating ? Colors.amber : Colors.grey,
          ),
          onPressed: () => widget.onRatingChanged(index + 1),
        );
      }),
    );
  }
}
