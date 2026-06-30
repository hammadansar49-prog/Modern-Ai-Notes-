import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/auth_repository.dart';
import '../../core/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Auth State
sealed class AuthState {
  const AuthState();
}

class AuthIdle extends AuthState {
  const AuthIdle();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final User? user;
  const AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthVerificationRequired extends AuthState {
  const AuthVerificationRequired();
}

class AuthRegisterSuccess extends AuthState {
  const AuthRegisterSuccess();
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final Ref _ref;
  StreamSubscription<User?>? _authSubscription;

  AuthNotifier(this._repository, this._ref) : super(const AuthIdle());

  void _initAuthListener() {
    _authSubscription?.cancel();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _ref.read(noteRepositoryProvider).syncFromFirestoreOnLogin();
        _ref.read(noteRepositoryProvider).startFirebaseSync();
        state = AuthSuccess(user);
      } else {
        state = const AuthIdle();
      }
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  User? get currentUser => _repository.currentUser;

  Future<void> login(String email, String password) async {
    state = const AuthLoading();
    final result = await _repository.login(email, password);
    
    if (result.isSuccess) {
      // CRITICAL FIX: Sync notes in background without blocking UI
      _ref.read(noteRepositoryProvider).syncFromFirestoreOnLogin();
      _ref.read(noteRepositoryProvider).startFirebaseSync();
      state = AuthSuccess(result.getOrNull());
    } else {
      final error = result.errorMessage ?? 'Login failed';
      if (error == 'VERIFICATION_REQUIRED') {
        state = const AuthVerificationRequired();
      } else {
        state = AuthError(error);
      }
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = const AuthLoading();
    final result = await _repository.register(name, email, password);
    
    if (result.isSuccess) {
      state = const AuthRegisterSuccess();
    } else {
      state = AuthError(result.errorMessage ?? 'Registration failed');
    }
  }

  Future<void> loginWithGoogle(AuthCredential credential) async {
    state = const AuthLoading();
    final result = await _repository.signInWithCredential(credential);
    
    if (result.isSuccess) {
      // CRITICAL FIX: Sync notes in background without blocking UI
      _ref.read(noteRepositoryProvider).syncFromFirestoreOnLogin();
      _ref.read(noteRepositoryProvider).startFirebaseSync();
      state = AuthSuccess(result.getOrNull());
    } else {
      state = AuthError(result.errorMessage ?? 'Google Sign-In failed');
    }
  }

  Future<void> logout() async {
    _ref.read(noteRepositoryProvider).stopFirebaseSync();
    await _ref.read(databaseProvider).clearAllData();
    _repository.logout();
    state = const AuthIdle();
  }

  Future<void> resendVerification(String email, String password) async {
    state = const AuthLoading();
    final result = await _repository.resendVerificationEmail(email, password);
    
    if (result.isSuccess) {
      state = const AuthError('Verification email sent. Check your inbox.');
    } else {
      state = AuthError(result.errorMessage ?? 'Failed to resend');
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AuthLoading();
    final result = await _repository.sendPasswordResetEmail(email);
    
    if (result.isSuccess) {
      state = const AuthIdle();
    } else {
      state = AuthError(result.errorMessage ?? 'Failed to send reset email');
    }
  }

  void clearError() {
    state = const AuthIdle();
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final notifier = AuthNotifier(repository, ref);
  notifier._initAuthListener();
  ref.onDispose(() => notifier.dispose());
  return notifier;
});