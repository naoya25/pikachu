import 'package:pikachu/models/pokemon.dart';
import 'package:pikachu/repositories/pokemon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_provider.g.dart';

@Riverpod(keepAlive: true)
class PokemonNotifier extends _$PokemonNotifier {
  @override
  Future<Map<int, Pokemon>> build() async {
    return {};
  }

  Future<void> fetchPokemons(List<int> ids) async {
    final currentState = state.value ?? {};
    final Map<int, Pokemon> updatedPokemons = {...currentState};

    for (final id in ids) {
      try {
        final pokemon = await fetchPokemon(id);
        updatedPokemons[id] = pokemon;
        await Future.delayed(const Duration(milliseconds: 100));
      } catch (e, stackTrace) {
        state = AsyncValue.error(e, stackTrace);
        return;
      }
    }

    state = AsyncValue.data(updatedPokemons);
  }
}
