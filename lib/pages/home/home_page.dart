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
    final isFavoriteMode = useState(false);

    useEffect(() {
      if (pokemonsAsyncValue.value?.isEmpty == true && !isFavoriteMode.value) {
        pokemonNotifier
            .addPokemons(List<int>.generate(10, (index) => index + 1));
      }
      return null;
    }, [pokemonsAsyncValue, isFavoriteMode.value]);

    // スクロールでデータの追加を行うかを判定する関数
    bool shouldLoadMore(ScrollNotification scrollNotification) {
      if (isFavoriteMode.value) return false;

      if (scrollNotification is ScrollEndNotification) {
        final before = scrollNotification.metrics.extentBefore;
        final max = scrollNotification.metrics.maxScrollExtent;
        if (before == max) {
          final currentLength = pokemonsAsyncValue.value?.length ?? 0;
          final nextIndex = currentLength + 1;

          if (nextIndex <= 1010) {
            final lastIndex = nextIndex + 9;
            final upperLimit = lastIndex <= 1010 ? lastIndex : 1010;
            pokemonNotifier.addPokemons(
              List<int>.generate(
                upperLimit - nextIndex + 1,
                (index) => nextIndex + index,
              ),
            );
            return true;
          }
        }
      }
      return false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _BottomSheet(
                    isFavorite: isFavoriteMode.value,
                    onTap: () async {
                      isFavoriteMode.value = !isFavoriteMode.value;
                      await pokemonNotifier
                          .toggleFavoriteMode(isFavoriteMode.value);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.auto_awesome_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: pokemonsAsyncValue.when(
              data: (pokemons) {
                return NotificationListener<ScrollNotification>(
                  onNotification: shouldLoadMore,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pokemons.length,
                    itemBuilder: (context, index) {
                      final id = pokemons.keys.elementAt(index);
                      return _ListItem(pokemon: pokemons[id]);
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Text('Error: $err'),
            ),
          ),
        ],
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

class _BottomSheet extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const _BottomSheet({
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String menuTitle = isFavorite ? '「すべて」表示に切り替え' : '「お気に入り」表示に切り替え';
    String menuSubtitle =
        isFavorite ? 'すべてのポケモンが表示されます' : 'お気に入りに登録したポケモンのみが表示されます';

    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            menuSubtitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: Text(menuTitle),
            subtitle: Text(menuSubtitle),
            onTap: onTap,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text('キャンセル'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
