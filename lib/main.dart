import 'package:flutter/material.dart' hide Page;
import 'package:quran/src/config/realm_copier.dart';
import 'package:quran/src/config/sqlite.dart';
import 'package:quran/src/settings/settings_controller.dart';
import 'package:quran/src/settings/settings_data.dart';
import 'package:quran/src/settings/settings_service.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SQLite.initialize();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Load data initially
  // surahs and juzs
  await SettingsData.initialize();
  await copyRealmDatabase();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const QuranApp());
}
