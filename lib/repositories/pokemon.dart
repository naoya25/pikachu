import 'dart:convert';

import 'package:pikachu/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:pikachu/utils/constant_value.dart';

Future<Pokemon> fetchPokemon(int id) async {
  final res = await http.get(
    Uri.parse('${ConstantValue.pokeApiRoute}/pokemon/$id'),
  );
  if (res.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load Pokemon');
  }
}
