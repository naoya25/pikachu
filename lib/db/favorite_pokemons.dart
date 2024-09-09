import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePokemonsDb {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'favorite_pokemons.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }
}
