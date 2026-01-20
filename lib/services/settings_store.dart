import 'package:settings_and_preferences/models/settings_model.dart';
import 'package:sqflite/sqflite.dart';

class SettingsStore {
  Database? _database;

  //------------------------------------------------------------------------------
  Future<void> init() async {
    _database = await openDatabase(
      'settings.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE settings(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            isDarkMode TEXT,
            fontSize TEXT,
            scriptLanguage TEXT,
            rememberSettings TEXT
          )
        ''');
      },
    );
  }

  //------------------------------------------------------------------------------
  Database get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call init() first.');
    }
    return _database!;
  }

  //------------------------------------------------------------------------------
  Future<void> saveSettings(SettingsModel settings) async {
    if (_database == null) return;

    await _database!.insert('settings', {
      'id': 1,
      'isDarkMode': settings.isDarkMode.toString(),
      'fontSize': settings.fontSize.toString(),
      'scriptLanguage': settings.scriptLanguage,
      'rememberSettings': settings.rememberSettings.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //------------------------------------------------------------------------------
  Future<Map<String, dynamic>?> loadSettings() async {
    if (_database == null) return null;

    final List<Map<String, dynamic>> maps = await _database!.query('settings');

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
