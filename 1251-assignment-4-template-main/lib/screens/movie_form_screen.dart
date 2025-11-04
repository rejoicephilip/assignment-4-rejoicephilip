import 'package:flutter/material.dart';
import 'package:assignment_04/models/movie.dart';
import 'package:assignment_04/managers/movie_manager.dart';
import 'package:assignment_04/widgets/star_rating.dart';

class MovieFormScreen extends StatefulWidget {
  final Movie? movie;

  const MovieFormScreen({this.movie, super.key});

  @override
  State<MovieFormScreen> createState() => _MovieFormScreenState();
}

class _MovieFormScreenState extends State<MovieFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController();
  final _directorController = TextEditingController();

  bool _watched = false;
  int _rating = 0;
  String? _ratingError;
  
  final _movieManager = MovieManager.instance;

  @override
  void initState() {
    super.initState();

    if (widget.movie != null) {
      _titleController.text = widget.movie!.title;
      _yearController.text = widget.movie!.year.toString();
      _directorController.text = widget.movie!.director ?? '';
      _watched = widget.movie!.watched;
      _rating = widget.movie!.rating ?? 0;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _directorController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    return _formKey.currentState!.validate();
  }

  Future<void> _saveMovie() async {

    setState(() {
      _ratingError = null;
    });

    final isValid = _validateForm();
    if (!isValid) {
      return;
    }

    if (_watched && _rating == 0){
      setState(() {
        _ratingError = 'Please add a rating for watched movies';
      });
      return;
    }

    final year = int.parse(_yearController.text.trim());

    final movie = Movie(
      id: widget.movie?.id,
      title: _titleController.text,
      year: year,
      director: _directorController.text.trim().isEmpty
        ? null
        : _directorController.text.trim(),
      watched: _watched,
      rating: _watched ? _rating : null,
    );

    if (widget.movie == null) {
      await _movieManager.insertMovie(movie);
    } else {
      await _movieManager.updateMovie(movie);
    }

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.movie != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Movie' : 'Add Movie')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a year';
                  }
                  
                  final trimmed = value.trim();
                  final parsedYear = int.tryParse(trimmed);
                  if (parsedYear == null) {
                    return 'Please enter a valid number';
                  }

                  if (parsedYear < 1888 || parsedYear > 2025) {
                    return 'Year must be between 1888 and 2025';
                  }
                  
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _directorController,
                decoration: const InputDecoration(
                  labelText: 'Director',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Watched'),
                value: _watched,
                onChanged: (value) {
                  setState(() {
                    _watched = value;
                    if (!value) {
                      _rating = 0;
                      _ratingError = null;
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Rating:'),
              StarRating(
                rating: _watched ? _rating : 0,
                isWatched: _watched,
                onRatingChanged:
                    _watched
                        ? (rating) {
                          setState(() {
                            _rating = rating;
                            _ratingError = null;  
                            });
                        }
                        : null,
              ),
              if (_ratingError != null) ...[
                  const SizedBox(height:4),
                  Text(
                    _ratingError!,
                    style: TextStyle( color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                    ),
                  ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveMovie,
                child: Text(isEditing ? 'Update' : 'Add'),
              ),
              if (isEditing) ...[
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    // noop
                  },
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
