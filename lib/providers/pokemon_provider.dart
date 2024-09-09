import 'package:pikachu/models/favorite_pokemon.dart';
import 'package:pikachu/models/pokemon.dart';
import 'package:pikachu/repositories/pokemon.dart';
import 'package:pikachu/utils/constant_value.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_provider.g.dart';

@Riverpod(keepAlive: true)
class PokemonNotifier extends _$PokemonNotifier {
  @override
  Future<Map<int, Pokemon>> build() async {
    return {};
  }

  Future<void> toggleFavoriteMode(bool isFavoriteMode) async {
    List<FavoritePokemon> favMock = [
      FavoritePokemon(pokemonId: 1),
      FavoritePokemon(pokemonId: 4),
      FavoritePokemon(pokemonId: 7),
    ];

    final Map<int, Pokemon> newPokemons;
    if (isFavoriteMode) {
      newPokemons = await getPokemons(
        favMock.map((f) => f.pokemonId).toList(),
      );
    } else {
      newPokemons = await getPokemons(
        List<int>.generate(10, (index) => index + 1),
      );
    }
    state = AsyncValue.data(newPokemons);
  }

  Future<void> addPokemons(List<int> ids) async {
    final currentState = state.value ?? {};
    final Map<int, Pokemon> newPokemons = await getPokemons(ids);

    state = AsyncValue.data({...currentState, ...newPokemons});
  }

  Future<Map<int, Pokemon>> getPokemons(List<int> ids) async {
    final Map<int, Pokemon> pokemons = {};

    for (final id in ids) {
      if (id > ConstantValue.pokeMaxId) continue;
      try {
        final pokemon = await fetchPokemon(id);
        pokemons[id] = pokemon;
      } catch (e, stackTrace) {
        state = AsyncValue.error(e, stackTrace);
      }
    }
    return pokemons;
  }
}
