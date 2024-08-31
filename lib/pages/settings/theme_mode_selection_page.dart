import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pikachu/providers/theme_provider.dart';

class ThemeModeSelectionPage extends ConsumerWidget {
  const ThemeModeSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeNotifierProvider);
    final themeModeNotifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('モードを選択してください'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: mode,
              title: const Text('System'),
              onChanged: (mode) async {
                if (mode != null) {
                  await themeModeNotifier.setTheme(mode);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: mode,
              title: const Text('Dark'),
              onChanged: (mode) async {
                if (mode != null) {
                  await themeModeNotifier.setTheme(mode);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: mode,
              title: const Text('Light'),
              onChanged: (mode) async {
                if (mode != null) {
                  await themeModeNotifier.setTheme(mode);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
