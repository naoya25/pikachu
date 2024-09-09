import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pikachu/components/custom_bottom_navigation_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark/Light Mode'),
            onTap: () {
              context.push('/setting_theme');
            },
          ),
          TextButton(
            onPressed: () {
              context.push('/sample');
            },
            child: const Text('go to sample page'),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
