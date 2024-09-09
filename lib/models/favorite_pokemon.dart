class FavoritePokemon {
  final int pokemonId;

  FavoritePokemon({
    required this.pokemonId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': pokemonId,
    };
  }
}
