import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/providers.dart';
import 'ui/auth/auth_provider.dart';
import 'ui/splash/splash_screen.dart';
import 'ui/auth/login_screen.dart';
import 'ui/auth/register_screen.dart';
import 'ui/notes/notes_list_screen.dart';
import 'ui/notes/note_editor_screen.dart';
import 'ui/notes/archive_screen.dart';
import 'ui/notes/trash_screen.dart';
import 'ui/notes/chat_screen.dart';
import 'ui/notes/manage_tags_screen.dart';
import 'ui/notes/settings_screen.dart';

class _AuthRefreshNotifier extends ChangeNotifier {
  void trigger() => notifyListeners();
}

final _authRefreshNotifier = _AuthRefreshNotifier();

final routerProvider = Provider<GoRouter>((ref) {
  ref.listen(authProvider, (_, __) => _authRefreshNotifier.trigger());

  return GoRouter(
    refreshListenable: _authRefreshNotifier,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState is AuthSuccess;
      final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!isLoggedIn && !isLoggingIn && state.matchedLocation != '/splash') {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/notes';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => const NotesListScreen(),
      ),
      GoRoute(
        path: '/editor',
        builder: (context, state) {
          final noteId = state.uri.queryParameters['noteId'];
          return NoteEditorScreen(noteId: noteId);
        },
      ),
      GoRoute(
        path: '/archive',
        builder: (context, state) => const ArchiveScreen(),
      ),
      GoRoute(
        path: '/trash',
        builder: (context, state) => const TrashScreen(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/tags',
        builder: (context, state) => const ManageTagsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});

class ModernNotesApp extends ConsumerWidget {
  const ModernNotesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    
    return MaterialApp.router(
      title: 'Modern AI Notes',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}