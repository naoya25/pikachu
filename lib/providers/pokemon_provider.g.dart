// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonNotifierHash() => r'74dc656e819685eb3c05ac3b94aa7d3ea5dbc557';

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
