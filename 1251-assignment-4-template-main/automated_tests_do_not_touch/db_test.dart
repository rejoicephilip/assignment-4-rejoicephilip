import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/managers/movie_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() {
  late MovieManager movieManager;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    movieManager = MovieManager.instance;
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'movies.db');

    try {
      await deleteDatabase(path);
    } catch (e) {
      print('Error deleting database: $e');
    }

    MovieManager.resetDatabase();
  });

  group('Database Operations', () {
    test('Movie table creation works properly', () async {
      final db = await movieManager.database;
      expect(db, isNotNull);

      final movies = await movieManager.getMovies();
      expect(movies, isA<List<Movie>>());
      expect(movies.isEmpty, true);
    });

    test('Can insert and retrieve a movie', () async {
      final testMovie = Movie(
        title: 'Test Movie',
        year: 2022,
        director: 'Test Director',
        watched: true,
        rating: 4,
      );

      final id = await movieManager.insertMovie(testMovie);
      expect(id, isA<int>());
      expect(id > 0, true);

      final movies = await movieManager.getMovies();
      expect(movies.length, 1);
      expect(movies[0].title, 'Test Movie');
      expect(movies[0].year, 2022);
    });

    test('Movie data types are preserved correctly', () async {
      final testMovie = Movie(
        title: 'Type Test',
        year: 1999,
        director: 'Type Director',
        watched: true,
        rating: 5,
      );

      await movieManager.insertMovie(testMovie);
      final movies = await movieManager.getMovies();

      expect(movies[0].year, isA<int>());
      expect(movies[0].watched, isA<bool>());
      expect(movies[0].rating, isA<int>());
    });

    test('Can update an existing movie', () async {
      final testMovie = Movie(
        title: 'Original Title',
        year: 2020,
        director: 'Original Director',
        watched: false,
        rating: 0,
      );

      final id = await movieManager.insertMovie(testMovie);

      final updatedMovie = Movie(
        id: id,
        title: 'Updated Title',
        year: 2020,
        director: 'Updated Director',
        watched: true,
        rating: 4,
      );

      await movieManager.updateMovie(updatedMovie);

      final movies = await movieManager.getMovies();
      expect(movies.length, 1);
      expect(movies[0].title, 'Updated Title');
      expect(movies[0].director, 'Updated Director');
      expect(movies[0].watched, true);
      expect(movies[0].rating, 4);
    });

    test('Multiple movies can be stored and retrieved', () async {
      await movieManager.insertMovie(
        Movie(
          title: 'Movie 1',
          year: 2021,
          director: 'Director 1',
          watched: true,
          rating: 5,
        ),
      );

      await movieManager.insertMovie(
        Movie(
          title: 'Movie 2',
          year: 2019,
          director: 'Director 2',
          watched: false,
          rating: 0,
        ),
      );

      await movieManager.insertMovie(
        Movie(
          title: 'Movie 3',
          year: 2022,
          director: 'Director 3',
          watched: true,
          rating: 3,
        ),
      );

      final movies = await movieManager.getMovies();
      expect(movies.length, 3);

      final ids = movies.map((m) => m.id).toSet();
      expect(ids.length, 3);
    });

    test('Can delete a movie', () async {
      final testMovie = Movie(
        title: 'To Be Deleted',
        year: 2018,
        director: 'Delete Director',
        watched: true,
        rating: 2,
      );

      final id = await movieManager.insertMovie(testMovie);

      var movies = await movieManager.getMovies();
      expect(movies.length, 1);

      try {
        await movieManager.deleteMovie(id);

        movies = await movieManager.getMovies();
        expect(movies.isEmpty, true);
      } catch (e) {
        fail('Delete operation failed: $e');
      }
    });
  });
}
