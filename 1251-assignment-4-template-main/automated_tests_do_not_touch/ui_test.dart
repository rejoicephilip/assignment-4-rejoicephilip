import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/widgets/movie_list_item.dart';
import 'package:assignment_04/widgets/star_rating.dart';

void main() {
  group('UI Components', () {
    testWidgets('MovieListItem displays correct movie data', (
      WidgetTester tester,
    ) async {
      final testMovie = Movie(
        id: 1,
        title: 'Test Movie',
        year: 2022,
        director: 'Test Director',
        watched: true,
        rating: 4,
      );

      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieListItem(
              movie: testMovie,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Test Movie'), findsOneWidget);
      expect(find.text('2022 - Test Director'), findsOneWidget);

      await tester.tap(find.byType(ListTile));
      expect(tapped, true);

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('MovieListItem handles empty director field', (
      WidgetTester tester,
    ) async {
      final testMovie = Movie(
        id: 1,
        title: 'No Director',
        year: 2020,
        director: '',
        watched: false,
        rating: 0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: MovieListItem(movie: testMovie, onTap: () {})),
        ),
      );

      expect(find.text('No Director'), findsOneWidget);
      expect(find.text('2020'), findsOneWidget);

      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('StarRating displays correct number of stars', (
      WidgetTester tester,
    ) async {
      int newRating = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: 3,
              onRatingChanged: (rating) {
                newRating = rating;
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_border), findsNWidgets(2));

      await tester.tap(find.byIcon(Icons.star_border).at(1));

      expect(newRating, 5);
    });

    testWidgets('StarRating handles watched status correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: 4,
              isWatched: false,
              onRatingChanged: null,
            ),
          ),
        ),
      );

      final starIcons = find.byIcon(Icons.star);
      expect(starIcons, findsNWidgets(5));
    });

    testWidgets('StarRating is interactive when watched', (
      WidgetTester tester,
    ) async {
      int newRating = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: 2,
              isWatched: true,
              onRatingChanged: (rating) {
                newRating = rating;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.star_border).at(1));

      expect(newRating > 0, true);
    });

    testWidgets('StarRating is not interactive when not watched', (
      WidgetTester tester,
    ) async {
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: 2,
              isWatched: false,
              onRatingChanged: (_) {
                callbackCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.star).first);

      expect(callbackCalled, false);
    });
  });
}
