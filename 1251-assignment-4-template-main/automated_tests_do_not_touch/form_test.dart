import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/screens/movie_form_screen.dart';
import 'package:assignment_04/managers/movie_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database db;
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  setUp(() async {
    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE movies(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, year TEXT, director TEXT, watched INTEGER, rating INTEGER)',
        );
      },
    );
    MovieManager.instance.setDatabase(db);
  });
  tearDown(() async {
    await db.delete('movies');
    await db.close();
  });

  group('Movie Form Validation', () {
    testWidgets('Title field requires a value', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MovieFormScreen()));

      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(find.text('Please enter a title'), findsOneWidget);
    });

    testWidgets('Year field validates numeric input', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MovieFormScreen()));

      await tester.enterText(find.widgetWithText(TextFormField, 'Year'), 'abc');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Test Movie',
      );

      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(find.text('Please enter a valid number'), findsOneWidget);
    });

    testWidgets('Year field validates range', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MovieFormScreen()));

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Year'),
        '1800',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Test Movie',
      );

      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(
        find.text('Year must be between 1888 and ${DateTime.now().year}'),
        findsOneWidget,
      );
    });

    testWidgets('Year field validates future years', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MovieFormScreen()));

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Year'),
        '${DateTime.now().year + 10}',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Test Movie',
      );

      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(
        find.text('Year must be between 1888 and ${DateTime.now().year}'),
        findsOneWidget,
      );
    });

    testWidgets('Watched movies require a rating', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MovieFormScreen()));

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Test Movie',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Year'),
        '2020',
      );

      await tester.tap(find.widgetWithText(SwitchListTile, 'Watched'));
      await tester.pump();

      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(
        find.text('Please add a rating for watched movies'),
        findsOneWidget,
      );
    });

    testWidgets('Valid form can be submitted', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MovieFormScreen()));

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Valid Movie',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Year'),
        '2022',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Director'),
        'Valid Director',
      );

      await tester.tap(find.widgetWithText(SwitchListTile, 'Watched'));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.star_border).at(3));
      await tester.pump();

      await tester.tap(find.text('Add'));
      await tester.pump();
    });
  });

  group('Movie Form Edit Mode', () {
    testWidgets('Form loads existing movie data', (WidgetTester tester) async {
      final testMovie = Movie(
        id: 1,
        title: 'Existing Movie',
        year: 2021,
        director: 'Existing Director',
        watched: true,
        rating: 4,
      );

      await tester.pumpWidget(
        MaterialApp(home: MovieFormScreen(movie: testMovie)),
      );

      expect(find.text('Existing Movie'), findsOneWidget);
      expect(find.text('2021'), findsOneWidget);
      expect(find.text('Existing Director'), findsOneWidget);

      expect(
        (tester.widget(find.byType(SwitchListTile)) as SwitchListTile).value,
        true,
      );

      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('Delete button is functional', (WidgetTester tester) async {
      final testMovie = Movie(
        id: 1,
        title: 'Existing Movie',
        year: 2021,
        director: 'Existing Director',
        watched: true,
        rating: 4,
      );

      await tester.pumpWidget(
        MaterialApp(home: MovieFormScreen(movie: testMovie)),
      );

      expect(find.text('Delete'), findsOneWidget);

      await tester.tap(find.text('Delete'));
      await tester.pump();
    });
  });
}
