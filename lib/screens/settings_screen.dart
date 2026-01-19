import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_and_preferences/models/settings_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: settings.isDarkMode,
              onChanged: (value) => settings.toggleDarkMode(value),
            ),
            Slider(
              min: 10.0,
              max: 30.0,
              value: settings.fontSize,
              onChanged: (value) => settings.setFontSize(value),
              label: 'Font Size: ${settings.fontSize.toStringAsFixed(1)}',
            ),
            DropdownButton<String>(
              value: settings.scriptLanguage,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'es', child: Text('Spanish')),
                DropdownMenuItem(value: 'fr', child: Text('French')),
              ],
              onChanged: (value) {
                if (value != null) {
                  settings.setScriptLanguage(value);
                }
              },
            ),
            CheckboxListTile(
              title: const Text('Remember Settings'),
              value: settings.rememberSettings,
              onChanged: (value) {
                if (value != null) {
                  settings.toggleRememberSettings(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
