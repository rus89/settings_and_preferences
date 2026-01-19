import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_and_preferences/screens/settings_screen.dart';
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
      home: HomePage(),
    );
  }
}

//------------------------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings App')),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome to Settings App',
              style: TextStyle(fontSize: settings.fontSize),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        },
      ),
    );
  }
}
