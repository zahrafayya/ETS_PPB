import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/movie.dart';

class MoviesDatabase {
  static final MoviesDatabase instance = MoviesDatabase._init();

  static Database? _database;

  MoviesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableMovies (
      ${MovieFields.id} $idType,
      ${MovieFields.title} $textType,
      ${MovieFields.imageUrl} $textType,
      ${MovieFields.description} $textType,
      ${MovieFields.time} $textType
    )
    ''');

    await db.insert(tableMovies,
        {
          MovieFields.id: 1,
          MovieFields.title: "The Prestige",
          MovieFields.imageUrl: "https://m.media-amazon.com/images/M/MV5BNDA0OWY4NGMtN2Q3Ny00YTU0LWExNWQtNzdlMDVlYzBhNThiXkEyXkFqcGdeQXVyMTAyOTE2ODg0._V1_.jpg",
          MovieFields.description: "After a tragic accident, two stage magicians in 1890s London engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.",
          MovieFields.time: DateTime.now().toIso8601String()
        }
    );

    await db.insert(tableMovies,
        {
          MovieFields.id: 2,
          MovieFields.title: "Oppenheimer",
          MovieFields.imageUrl: "https://m.media-amazon.com/images/M/MV5BMDBmYTZjNjUtN2M1MS00MTQ2LTk2ODgtNzc2M2QyZGE5NTVjXkEyXkFqcGdeQXVyNzAwMjU2MTY@._V1_FMjpg_UX1000_.jpg",
          MovieFields.description: "The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.",
          MovieFields.time: DateTime.now().toIso8601String()
        }
    );

    await db.insert(tableMovies,
        {
          MovieFields.id: 3,
          MovieFields.title: "Wish",
          MovieFields.imageUrl: "https://m.media-amazon.com/images/M/MV5BYWQ4M2ZmODItNzZhYi00MzY1LTk2ZmItYTUwODI2NzJmN2JiXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_FMjpg_UX1000_.jpg",
          MovieFields.description: "A young girl named Asha wishes on a star and gets a more direct answer than she bargained for when a trouble-making star comes down from the sky to join her.",
          MovieFields.time: DateTime.now().toIso8601String()
        }
    );
  }

  Future<Movie> createMovie(Movie movie) async {
    final db = await instance.database;

    final id = await db.insert(tableMovies, movie.toJson());
    return movie.copy(id: id);
  }

  Future<Movie> readMovie(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMovies,
      columns: MovieFields.values,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<Movie>> readAllMovies() async {
    final db = await instance.database;

    final orderBy = '${MovieFields.time} ASC';
    final result = await db.query(tableMovies, orderBy: orderBy);

    return result.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> updateMovie(Movie movie) async {
    final db = await instance.database;

    return db.update(
        tableMovies,
        movie.toJson(),
        where: '${MovieFields.id} = ?',
        whereArgs: [movie.id]
    );
  }

  Future<int> deleteMovie(int id) async {
    final db = await instance.database;

    return await db.delete(
        tableMovies,
        where: '${MovieFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}