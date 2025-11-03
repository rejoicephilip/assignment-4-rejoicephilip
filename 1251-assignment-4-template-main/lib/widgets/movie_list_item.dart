import 'package:flutter/material.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/widgets/star_rating.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieListItem({required this.movie, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        movie.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${movie.year}${movie.director.isNotEmpty ? " - ${movie.director}" : ""}',
          ),
          const SizedBox(height: 4),
          StarRating(
            rating: movie.rating,
            size: 16,
            isWatched: movie.watched,
            onRatingChanged: null,
          ),
        ],
      ),
      trailing: Icon(
        movie.watched ? Icons.check_circle_outline : Icons.check_circle,
        color: movie.watched ? Colors.grey : Colors.green,
      ),
      onTap: onTap,
    );
  }
}
