import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/settings_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsModel(),
      child: const SettingsApp(),
    ),
  );
}

//------------------------------------------------------------------------------
class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

//------------------------------------------------------------------------------
class _SettingsAppState extends State<SettingsApp> {
  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsModel>();

    return MaterialApp(
      theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
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
      ),
    );
  }
}
