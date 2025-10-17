import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/hive_models/theme_selected_model/theme_selected_model.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeKey = 'selectedTheme';

  final Box _themeBox =  Hive.box('themeSettings');
  AppTheme _selectedTheme = AppTheme.system;
  bool _isDarkMode = false;

  AppTheme get selectedTheme => _selectedTheme;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode {
    switch (_selectedTheme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.system:
      return ThemeMode.system;
    }
  }

  ThemeProvider() {
    _loadTheme();
  }


  Future<void> _loadTheme() async {
    final savedTheme = _themeBox.get(_themeKey, defaultValue: AppTheme.system);
    _selectedTheme = savedTheme;
    _updateDarkModeStatus();
    notifyListeners();
  }

  Future<void> setTheme(AppTheme theme) async {
    _selectedTheme = theme;
    await _themeBox.put(_themeKey, theme);
    _updateDarkModeStatus();
    notifyListeners();
  }

  void _updateDarkModeStatus() {
    if (_selectedTheme == AppTheme.dark) {
      _isDarkMode = true;
    } else if (_selectedTheme == AppTheme.light) {
      _isDarkMode = false;
    } else {
      final platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _isDarkMode = platformBrightness == Brightness.dark;
    }
  }
}