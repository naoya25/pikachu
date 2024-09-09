import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pikachu/pages/home/home_page.dart';
import 'package:pikachu/pages/settings/settings_page.dart';
import 'package:pikachu/pages/settings/theme_mode_selection_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
    GoRoute(
      path: '/setting_theme',
      name: 'setting_theme',
      builder: (context, state) {
        return const ThemeModeSelectionPage();
      },
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
