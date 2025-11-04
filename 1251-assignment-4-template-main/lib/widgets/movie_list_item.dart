import 'package:flutter/material.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/widgets/star_rating.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieListItem({required this.movie, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {

    final hasDirector =
      movie.director != null && movie.director!.trim().isNotEmpty;
    final subtitleText =
      '${movie.year}${hasDirector ? " - ${movie.director}" : ""}';

    return ListTile(
      title: Text(
        movie.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitleText
          ),
          const SizedBox(height: 4),
          StarRating(
            rating: movie.watched ? (movie.rating ?? 0) : 0,
            size: 16,
            isWatched: movie.watched,
            onRatingChanged: null,
          ),
        ],
      ),
        trailing: Icon(
        movie.watched ? Icons.check_circle : Icons.check_circle_outline,
        color: movie.watched ? Colors.green : Colors.grey,
      ),
      onTap: onTap,
    ); 
  }
}
