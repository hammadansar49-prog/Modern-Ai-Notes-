import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<Result<User>> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      
      if (user != null) {
        if (user.emailVerified) {
          await _updateUserLastLogin(user.uid);
          return Result.success(user);
        } else {
          await user.sendEmailVerification();
          await _auth.signOut();
          return Result.failure('VERIFICATION_REQUIRED');
        }
      }
      return Result.failure('Login failed');
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Authentication error');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> register(String name, String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      
      if (user != null) {
        await _createUserInFirestore(user.uid, name, email);
        await user.sendEmailVerification();
        await _auth.signOut();
        return Result.success(null);
      }
      return Result.failure('Registration failed');
    } on FirebaseAuthException catch (e) {
      return Result.failure(e.message ?? 'Registration error');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> resendVerificationEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await result.user?.sendEmailVerification();
      await _auth.signOut();
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<User>> signInWithCredential(AuthCredential credential) async {
    try {
      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      
      if (user != null) {
        await _createUserInFirestoreIfNotExists(user.uid, user.displayName ?? '', user.email ?? '');
        await _updateUserLastLogin(user.uid);
        return Result.success(user);
      }
      return Result.failure('Google Sign-In failed');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<void> _createUserInFirestore(String uid, String name, String email) async {
    final userMap = {
      'name': name,
      'email': email,
      'profileImage': '',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'lastLogin': DateTime.now().millisecondsSinceEpoch,
    };
    await _firestore.collection('users').doc(uid).set(userMap, SetOptions(merge: true));
  }

  Future<void> _createUserInFirestoreIfNotExists(String uid, String name, String email) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      await _createUserInFirestore(uid, name, email);
    }
  }

  Future<void> _updateUserLastLogin(String uid) async {
    await _firestore.collection('users').doc(uid)
        .update({'lastLogin': DateTime.now().millisecondsSinceEpoch});
  }

  void logout() {
    _auth.signOut();
  }
}

class Result<T> {
  final T? data;
  final String? errorMessage;
  final bool isSuccess;

  Result._({this.data, this.errorMessage, required this.isSuccess});

  factory Result.success(T data) => Result._(data: data, isSuccess: true);
  factory Result.failure(String error) => Result._(errorMessage: error, isSuccess: false);

  T? getOrNull() => data;
}