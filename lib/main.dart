import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_and_preferences/screens/settings_screen.dart';
import 'package:settings_and_preferences/services/settings_store.dart';
import 'models/settings_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsStore = SettingsStore();
  await settingsStore.init();
  final settingsModel = SettingsModel(settingsStore);
  await settingsModel.loadSettings();

  runApp(
    MultiProvider(
      providers: [
        Provider<SettingsStore>.value(value: settingsStore),
        ChangeNotifierProvider.value(value: settingsModel),
      ],
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
    TextScaler textScaler = TextScaler.linear(settings.fontSize / 14.0);

    return MaterialApp(
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: textScaler),
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomePage(),
    );
  }
}

//------------------------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings App')),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to Settings App'),
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
