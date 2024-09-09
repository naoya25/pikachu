import 'package:pikachu/db/favorite_pokemons.dart';
import 'package:pikachu/models/favorite_pokemon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_provider.g.dart';

@riverpod
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  Future<List<FavoritePokemon>> build() async {
    return await FavoritePokemonsDB.read();
  }

  Future<void> toggle(FavoritePokemon fav) async {
    if (isExist(fav.pokemonId)) {
      await delete(fav);
    } else {
      await add(fav);
    }
  }

  bool isExist(int id) {
    final favoritePokemons = state.value ?? [];
    return favoritePokemons.any((fav) => fav.pokemonId == id);
  }

  Future<void> add(FavoritePokemon fav) async {
    final currentFavorites = state.value ?? [];
    await FavoritePokemonsDB.create(fav);
    state = AsyncValue.data([...currentFavorites, fav]);
  }

  Future<void> delete(FavoritePokemon fav) async {
    final currentFavorites = state.value ?? [];
    await FavoritePokemonsDB.delete(fav.pokemonId);
    state = AsyncValue.data(
      currentFavorites.where((item) => item.pokemonId != fav.pokemonId).toList(),
    );
  }
}
