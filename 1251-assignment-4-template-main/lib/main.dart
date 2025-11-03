import 'package:flutter/material.dart';
import 'package:assignment_04/screens/welcome_screen.dart';
import 'package:assignment_04/screens/movie_list_screen.dart';
import 'package:assignment_04/screens/movie_form_screen.dart';
import 'package:assignment_04/managers/preferences_manager.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/routes.dart' as routes;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PreferencesManager _prefsManager = PreferencesManager.instance;
  bool _isFirstRun = true;
  bool _darkMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final isFirstRun = await _prefsManager.isFirstRun();

    setState(() {
      _isFirstRun = isFirstRun;
      _isLoading = false;
    });
  }

  void _setDarkMode(bool value) {
    setState(() {
      _darkMode = value;
    });
    _prefsManager.setDarkMode(value);
  }

  void _completeFirstRun() {
    setState(() {
      _isFirstRun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      title: 'Movie Tracker',
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case routes.welcome:
            return MaterialPageRoute(
              builder: (_) => WelcomeScreen(onComplete: _completeFirstRun),
            );

          case routes.movieList:
            return MaterialPageRoute(
              builder:
                  (_) => MovieListScreen(
                    darkMode: _darkMode,
                    onThemeChanged: _setDarkMode,
                  ),
            );

          case routes.addMovie:
            return MaterialPageRoute(builder: (_) => const MovieFormScreen());

          case routes.editMovie:
            final movie = settings.arguments as Movie;
            return MaterialPageRoute(
              builder: (_) => MovieFormScreen(movie: movie),
            );

          default:
            return MaterialPageRoute(
              builder:
                  (_) => const Scaffold(
                    body: Center(child: Text('Route not found')),
                  ),
            );
        }
      },
      home:
          _isFirstRun
              ? WelcomeScreen(onComplete: _completeFirstRun)
              : MovieListScreen(
                darkMode: _darkMode,
                onThemeChanged: _setDarkMode,
              ),
    );
  }
}
