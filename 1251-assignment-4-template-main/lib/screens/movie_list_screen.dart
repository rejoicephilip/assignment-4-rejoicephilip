import 'package:flutter/material.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/managers/movie_manager.dart';
import 'package:assignment_04/managers/preferences_manager.dart';
import 'package:assignment_04/widgets/movie_list_item.dart';
import 'package:assignment_04/routes.dart' as routes;

class MovieListScreen extends StatefulWidget {
  final bool darkMode;
  final Function(bool) onThemeChanged;

  const MovieListScreen({
    required this.darkMode,
    required this.onThemeChanged,
    super.key,
  });

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final _movieManager = MovieManager.instance;
  final _prefsManager = PreferencesManager.instance;
  List<Movie> _movies = [];
  String _userName = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final movies = await _movieManager.getMovies();
    final userName = await _prefsManager.getUserName();

    setState(() {
      _movies = movies;
      _userName = userName ?? 'User';
      _isLoading = false;
    });
  }

  Future<void> _addMovie() async {
    final result = await Navigator.pushNamed(context, routes.addMovie);
  }

  Future<void> _editMovie(Movie movie) async {
    final result = await Navigator.pushNamed(
      context,
      routes.editMovie,
      arguments: movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_userName\'s Movies'),
        actions: [
          IconButton(
            icon: Icon(widget.darkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              widget.onThemeChanged(!widget.darkMode);
            },
            tooltip:
                widget.darkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _movies.isEmpty
              ? const Center(
                child: Text('No movies yet. Add your first movie!'),
              )
              : ListView.separated(
                itemCount: _movies.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final movie = _movies[0];
                  return MovieListItem(
                    movie: movie,
                    onTap: () => _editMovie(movie),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMovie,
        child: const Icon(Icons.add),
      ),
    );
  }
}
