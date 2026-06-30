import 'package:shared_preferences/shared_preferences.dart';

enum AppThemePreference { light, dark, system }

class UserPreferencesRepository {
  final SharedPreferences _prefs;

  UserPreferencesRepository(this._prefs);

  // Keys
  static const String _lastEmailKey = 'last_email';
  static const String _rememberMeKey = 'remember_me';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _isGridViewKey = 'is_grid_view';
  static const String _aiApiKeyKey = 'ai_api_key';
  static const String _themePreferenceKey = 'theme_preference';
  static const String _hapticEnabledKey = 'haptic_enabled';
  static const String _soundEnabledKey = 'sound_enabled';

  // Getters
  String get lastEmail => _prefs.getString(_lastEmailKey) ?? '';
  bool get rememberMe => _prefs.getBool(_rememberMeKey) ?? false;
  bool get biometricEnabled => _prefs.getBool(_biometricEnabledKey) ?? false;
  bool get isGridView => _prefs.getBool(_isGridViewKey) ?? true;
  String get aiApiKey => _prefs.getString(_aiApiKeyKey) ?? '';
  AppThemePreference get themePreference => AppThemePreference.values[_prefs.getInt(_themePreferenceKey) ?? 2];
  bool get hapticEnabled => _prefs.getBool(_hapticEnabledKey) ?? true;
  bool get soundEnabled => _prefs.getBool(_soundEnabledKey) ?? true;

  // Setters
  Future<void> setLastEmail(String email) => _prefs.setString(_lastEmailKey, email);
  Future<void> setRememberMe(bool enabled) => _prefs.setBool(_rememberMeKey, enabled);
  Future<void> setBiometricEnabled(bool enabled) => _prefs.setBool(_biometricEnabledKey, enabled);
  Future<void> setGridView(bool isGrid) => _prefs.setBool(_isGridViewKey, isGrid);
  Future<void> setAiApiKey(String apiKey) => _prefs.setString(_aiApiKeyKey, apiKey);
  Future<void> setThemePreference(AppThemePreference theme) => _prefs.setInt(_themePreferenceKey, theme.index);
  Future<void> setHapticEnabled(bool enabled) => _prefs.setBool(_hapticEnabledKey, enabled);
  Future<void> setSoundEnabled(bool enabled) => _prefs.setBool(_soundEnabledKey, enabled);

  // Clear all
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}