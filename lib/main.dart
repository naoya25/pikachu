import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pikachu/providers/theme_provider.dart';
import 'package:pikachu/router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return FutureBuilder(
      future: themeNotifier.loadTheme(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp.router(
            routerDelegate: goRouter.routerDelegate,
            routeInformationParser: goRouter.routeInformationParser,
            routeInformationProvider: goRouter.routeInformationProvider,
            title: 'ポケモンゲットだぜ',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: mode,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
