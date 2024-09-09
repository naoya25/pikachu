import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pikachu/components/custom_bottom_navigation_bar.dart';
import 'package:pikachu/gen/assets.gen.dart';
import 'package:pikachu/models/pokemon.dart';
import 'package:pikachu/pages/detail/detail_page.dart';
import 'package:pikachu/providers/pokemon_provider.dart';
import 'package:pikachu/utils/colors.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNotifier = ref.read(pokemonNotifierProvider.notifier);
    final pokemonsAsyncValue = ref.watch(pokemonNotifierProvider);

    useEffect(() {
      Future.microtask(() {
        final currentLength = pokemonsAsyncValue.value?.length ?? 0;
        if (currentLength == 0) {
          pokemonNotifier.fetchPokemons(
            List<int>.generate(10, (index) => index + 1),
          );
        }
      });
      return null;
    }, [pokemonsAsyncValue]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: pokemonsAsyncValue.when(
          data: (pokemons) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  final before = scrollNotification.metrics.extentBefore;
                  final max = scrollNotification.metrics.maxScrollExtent;
                  if (before == max) {
                    final currentLength = pokemonsAsyncValue.value?.length ?? 0;
                    final nextIndex = currentLength + 1;

                    if (nextIndex <= 1010) {
                      final lastIndex = nextIndex + 9;
                      final upperLimit = lastIndex <= 1010 ? lastIndex : 1010;
                      pokemonNotifier.fetchPokemons(
                        List<int>.generate(upperLimit - nextIndex + 1,
                            (index) => nextIndex + index),
                      );
                    }
                  }
                }
                return false;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final id = index + 1;
                  return _ListItem(pokemon: pokemons[id]);
                },
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('err: $err'),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class _ListItem extends StatelessWidget {
  final Pokemon? pokemon;

  const _ListItem({
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 80,
        decoration: BoxDecoration(
          color: (pokeTypeColors[pokemon?.types.first] ?? Colors.grey[100])
              ?.withOpacity(.3),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: pokemon != null
                ? NetworkImage(pokemon!.imageUrl)
                : Assets.images.cat.image().image,
          ),
        ),
      ),
      title: Text(
        pokemon != null ? pokemon!.name : 'err',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        pokemon != null ? pokemon!.types.first : 'err',
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return DetailPage(pokemon: pokemon);
          }),
        );
      },
    );
  }
}
