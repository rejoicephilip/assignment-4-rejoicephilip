class Movie {
  final int? id;
  final String title;
  final int year;
  final String director;
  final bool watched;
  final int rating;

  const Movie({
    this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.watched,
    required this.rating,
  });

  factory Movie.fromMap(Map<String, dynamic> movieMap) {
    return Movie(
      id: movieMap['id'] as int,
      title: movieMap['title'] as String,
      year: movieMap['year'] as int,
      director: movieMap['director'] as String,
      watched: movieMap['watched'] == 1,
      rating: movieMap['rating'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'director': director,
      'watched': watched ? 1 : 0,
      'rating': rating,
    };
  }
}
