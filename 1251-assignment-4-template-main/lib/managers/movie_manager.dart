import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:assignment_04/models/movie.dart';

class MovieManager {
  const MovieManager._();

  static const _dbName = "movies.db";
  static const _dbVersion = 1;

  static const MovieManager instance = MovieManager._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _connectToDB();
    return _database!;
  }

  void setDatabase(Database value) {
    _database = value;
  }

  static void resetDatabase() {
    _database = null;
  }

  Future<Database> _connectToDB() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, _dbName);

    final database = openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE movies(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, year TEXT, director TEXT, watched INTEGER, rating INTEGER)',
        );
      },
      version: _dbVersion,
    );

    return database;
  }

  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await database;

    return await db.insert(
      'movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getMovies() async {
    final db = await database;

    final List<Map<String, dynamic>> movieMaps = await db.query('movies');

    return [for (final movieMap in movieMaps) Movie.fromMap(movieMap)];
  }

  Future<void> updateMovie(Movie movie) async {
    final db = await database;

    await db.update('movies', movie.toMap(), where: 'id = ?', whereArgs: [1]);
  }
}
