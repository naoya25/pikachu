import 'package:flutter/material.dart';
import 'package:pikachu/models/pokemon.dart';
import 'package:pikachu/providers/favorites_provider.dart';
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

  /// お気に入りモードを切り替えるメソッド
  Future<void> toggleFavoriteMode(bool isFavoriteMode) async {
    final favoritePokemons = await ref.read(favoritesNotifierProvider.future);

    if (isFavoriteMode && favoritePokemons.isNotEmpty) {
      final favoriteIds = favoritePokemons.map((f) => f.pokemonId).toList();
      state = const AsyncValue.loading();
      final newPokemons = await getPokemons(favoriteIds);
      state = AsyncValue.data(newPokemons);
    } else {
      final newPokemons =
          await getPokemons(List<int>.generate(10, (index) => index + 1));
      state = AsyncValue.data(newPokemons);
    }
  }

  /// 新しいポケモンを追加するメソッド
  Future<void> addPokemon(int id) async {
    final currentState = state.value ?? {};
    // 未取得のポケモンのみをフェッチ
    if (!currentState.containsKey(id)) {
      final newPokemons = await getPokemons([id]);
      state = AsyncValue.data({...currentState, ...newPokemons});
    }
  }

  Future<void> addPokemons(List<int> ids) async {
    final currentState = state.value ?? {};
    // 未取得のポケモンのみをフェッチ
    final idsToFetch =
        ids.where((id) => !currentState.containsKey(id)).toList();

    if (idsToFetch.isNotEmpty) {
      final newPokemons = await getPokemons(idsToFetch);
      state = AsyncValue.data({...currentState, ...newPokemons});
    }
  }

  /// ポケモンIDリストからポケモンを取得するメソッド
  Future<Map<int, Pokemon>> getPokemons(List<int> ids) async {
    final Map<int, Pokemon> pokemons = {};

    for (final id in ids) {
      if (id > ConstantValue.pokeMaxId) continue; // 最大IDを超えた場合は無視
      try {
        final pokemon = await fetchPokemon(id);
        pokemons[id] = pokemon;
      } catch (e, _) {
        debugPrint('Error fetching Pokemon ID: $id, $e');
      }
    }
    return pokemons;
  }

  /// ポケモンを削除するメソッド
  Future<void> deletePokemon(int id) async {
    final currentState = state.value ?? {};

    // 現在のポケモンの状態にIDが含まれているか確認
    if (currentState.containsKey(id)) {
      // ポケモンを削除する
      final updatedPokemons = Map<int, Pokemon>.from(currentState)..remove(id);

      state = AsyncValue.data(updatedPokemons);
    }
  }
}
