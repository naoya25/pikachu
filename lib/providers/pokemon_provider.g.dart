// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonNotifierHash() => r'95166084acf635242da63b46b4de94042fc0720f';

/// See also [PokemonNotifier].
@ProviderFor(PokemonNotifier)
final pokemonNotifierProvider =
    AsyncNotifierProvider<PokemonNotifier, Map<int, Pokemon>>.internal(
  PokemonNotifier.new,
  name: r'pokemonNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pokemonNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PokemonNotifier = AsyncNotifier<Map<int, Pokemon>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
