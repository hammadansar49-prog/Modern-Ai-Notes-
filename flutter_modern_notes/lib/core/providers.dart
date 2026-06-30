import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/local/database.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/note_repository.dart';
import '../data/repository/collaboration_repository.dart';
import '../data/repository/user_preferences_repository.dart';

// Shared Preferences Provider
final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main.dart');
});

// Theme Mode Provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return ThemeModeNotifier(prefs);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferences _prefs;
  static const String _key = 'theme_mode';

  ThemeModeNotifier(this._prefs) : super(_getInitialMode(_prefs));

  static ThemeMode _getInitialMode(SharedPreferences prefs) {
    final saved = prefs.getString(_key);
    switch (saved) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    String value;
    switch (mode) {
      case ThemeMode.light: value = 'light'; break;
      case ThemeMode.dark: value = 'dark'; break;
      default: value = 'system';
    }
    await _prefs.setString(_key, value);
  }
}

// Database Provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// User ID Provider (Reactive to Auth changes)
final userIdProvider = StreamProvider<String?>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);
});

// Repository Providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final database = ref.watch(databaseProvider);
  final repo = NoteRepository(database);
  
  ref.listen(userIdProvider, (previous, next) {
    if (next.value != null) {
      repo.syncFromFirestoreOnLogin();
      repo.startFirebaseSync();
    }
  });

  return repo;
});

final collaborationRepositoryProvider = Provider<CollaborationRepository>((ref) {
  return CollaborationRepository();
});

final userPreferencesRepositoryProvider = Provider<UserPreferencesRepository>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return UserPreferencesRepository(prefs);
});

// UI State Providers
final isGridViewProvider = StateProvider<bool>((ref) => true);