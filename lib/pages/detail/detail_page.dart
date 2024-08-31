import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ポケモンゲットだぜ'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Detail'),
            Image.network(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
            ),
          ],
        ),
      ),
    );
  }
}
