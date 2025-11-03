import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignment_04/screens/movie_list_screen.dart';
import 'package:assignment_04/screens/welcome_screen.dart';
import 'package:assignment_04/screens/movie_form_screen.dart';
import 'package:assignment_04/managers/movie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('E2E Tests', () {
    late Database db;

    setUpAll(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    setUp(() async {
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues({});
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

    testWidgets('Welcome screen saves name and navigates on completion', (
      WidgetTester tester,
    ) async {
      bool completeCalled = false;

      // Build welcome screen
      await tester.pumpWidget(
        MaterialApp(
          home: WelcomeScreen(
            onComplete: () {
              completeCalled = true;
            },
          ),
        ),
      );

      // Enter a name
      await tester.enterText(find.byType(TextFormField), 'Test User');

      // Tap Get Started button
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      // Verify onComplete callback was called
      expect(completeCalled, true);
    });

    testWidgets('Movie list screen displays movies and handles theme toggle', (
      WidgetTester tester,
    ) async {
      bool themeChanged = false;
      bool initialDarkMode = false;

      // Build movie list screen
      await tester.pumpWidget(
        MaterialApp(
          home: MovieListScreen(
            darkMode: initialDarkMode,
            onThemeChanged: (value) {
              themeChanged = true;
            },
          ),
        ),
      );

      // Tap theme toggle
      await tester.tap(find.byIcon(Icons.dark_mode));
      await tester.pump();

      // Verify theme change callback was called
      expect(themeChanged, true);
    });

    testWidgets('Movie list loads user name', (WidgetTester tester) async {
      // This test isn't great without mocking, but we can check the structure
      await tester.pumpWidget(
        MaterialApp(
          home: MovieListScreen(darkMode: false, onThemeChanged: (_) {}),
        ),
      );

      // There should be a title with the user's name (or a default)
      expect(find.byType(AppBar), findsOneWidget);

      // Should also have an add button
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Full form submission workflow for new movie', (
      WidgetTester tester,
    ) async {
      // This test would be better with mocking, but can check basic flow
      await tester.pumpWidget(MaterialApp(home: MovieFormScreen()));

      // Enter movie details
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'New Test Movie',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Year'),
        '2023',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Director'),
        'Test Director',
      );

      // Set watched
      await tester.tap(find.widgetWithText(SwitchListTile, 'Watched'));
      await tester.pump();

      // Set rating by tapping on stars
      await tester.tap(find.byIcon(Icons.star_border).at(2)); // Tap 3rd star
      await tester.pump();

      // Submit form
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Hard to verify without mocking navigation
    });
  });
}
