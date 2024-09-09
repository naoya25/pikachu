import 'package:path/path.dart';
import 'package:pikachu/models/favorite_pokemon.dart';
import 'package:pikachu/utils/constant_value.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePokemonsDB {
  static Future<Database> openDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), ConstantValue.favFileName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE ${ConstantValue.favTableName}(id INTEGER PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }

  static Future<void> create(FavoritePokemon fav) async {
    var db = await openDB();
    await db.insert(
      ConstantValue.favTableName,
      fav.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<FavoritePokemon>> read() async {
    var db = await openDB();
    final List<Map<String, dynamic>> maps =
        await db.query(ConstantValue.favTableName);
    return List.generate(maps.length, (index) {
      return FavoritePokemon(
        pokemonId: maps[index]['id'],
      );
    });
  }

  static Future<void> delete(int pokeId) async {
    var db = await openDB();
    await db.delete(
      ConstantValue.favTableName,
      where: 'id = ?',
      whereArgs: [pokeId],
    );
  }
}
