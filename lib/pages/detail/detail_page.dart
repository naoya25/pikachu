import 'package:flutter/material.dart';
import 'package:pikachu/models/pokemon.dart';
import 'package:pikachu/utils/colors.dart';

class DetailPage extends StatelessWidget {
  final Pokemon? pokemon;
  const DetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ポケモンゲットだぜ'),
          centerTitle: true,
        ),
        body: const Center(child: Text('err')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポケモンゲットだぜ'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    pokemon!.imageUrl,
                    height: 100,
                    width: 100,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'No.${pokemon!.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              pokemon!.name,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon!.types.map((type) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Chip(
                    backgroundColor: pokeTypeColors[type] ?? Colors.grey,
                    label: Text(
                      type,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (pokeTypeColors[type] ?? Colors.grey)
                                    .computeLuminance() >
                                0.5
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
