import 'package:flutter/material.dart';
import 'package:quran/src/settings/settings_controller.dart';
import 'package:quran/src/settings/settings_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsController settingsController =
      SettingsController(SettingsService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
      ),
      body: Column(
        children: [
          Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {})
        ],
      ),
    );
  }
}
