import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/models/surah.dart';
import 'package:quran/src/settings/settings_controller.dart';
import 'package:quran/src/settings/settings_service.dart';

import 'src/app.dart';

Future<void> loadSurahs() async {
  List<Surah> surahs = await Surah.getAll();
  Get.put(surahs, tag: 'surahs');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLite.initialize();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  await loadSurahs();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const QuranApp());
}
