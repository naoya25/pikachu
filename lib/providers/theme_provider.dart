import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await saveTheme();
  }

  Future<void> saveTheme() async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt('theme', toInt(state));
  }

  Future<void> loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    state = toMode(pref.getInt('theme') ?? 0);
  }
}

int toInt(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.dark:
      return 1;
    case ThemeMode.light:
      return 2;
    default:
      return 0;
  }
}

ThemeMode toMode(int val) {
  switch (val) {
    case 1:
      return ThemeMode.dark;
    case 2:
      return ThemeMode.light;
    default:
      return ThemeMode.system;
  }
}
