import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final Function(int)? onRatingChanged;
  final double size;
  final bool isWatched;

  const StarRating({
    required this.rating,
    this.onRatingChanged,
    this.size = 24,
    this.isWatched = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Colors.amber;
    final Color inactiveColor = Colors.grey;
    final Color unWatchedColor = Colors.grey.withAlpha(75);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData icon;
        Color color;

        if (isWatched) {
          icon = index < rating ? Icons.star : Icons.star_border;
          color = index < rating ? activeColor : inactiveColor;
        } else {
          icon = Icons.star;
          color = unWatchedColor;
        }

        return GestureDetector(
          onTap:
              (onRatingChanged != null) ? () => onRatingChanged!(index) : null,
          child: Icon(icon, color: color, size: size),
        );
      }),
    );
  }
}
