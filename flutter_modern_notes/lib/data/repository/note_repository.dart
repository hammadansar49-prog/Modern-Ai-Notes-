import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../local/database.dart';
import '../model/note.dart' as model;
import '../model/tag.dart' as model_tag;

class NoteRepository {
  final AppDatabase _database;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription? _syncSubscription;

  NoteRepository(this._database);

  String? get _userId => _auth.currentUser?.uid;
  String get _userNotesPath => 'users/$_userId/notes';

  // ==================== NOTE STREAMS ====================

  Stream<List<model.Note>> getNotes() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);
    return _database.getAllNotes(uid);
  }

  Stream<List<model.Note>> getArchivedNotes() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);
    return _database.getArchivedNotes(uid);
  }

  Stream<List<model.Note>> getDeletedNotes() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);
    return _database.getDeletedNotes(uid);
  }

  Stream<List<model.Note>> getNotesByTag(int tagId) {
    final uid = _userId;
    if (uid == null) return Stream.value([]);
    return _database.getNotesByTag(tagId, uid);
  }

  Future<model.Note?> getNoteById(String noteId) async {
    return _database.getNoteById(noteId);
  }

  // ==================== NOTE OPERATIONS ====================

  Future<void> saveNote(model.Note note) async {
    final uid = _userId;
    if (uid == null) return;

    final updatedNote = note.copyWith(
      userId: uid,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    
    await _database.insertOrUpdateNote(updatedNote);
    await _syncNoteToFirebase(updatedNote);
  }

  Future<void> archiveNote(model.Note note) async {
    final updatedNote = note.copyWith(
      isArchived: true,
      isPinned: false,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _database.insertOrUpdateNote(updatedNote);
    await _syncNoteToFirebase(updatedNote);
  }

  Future<void> deleteNote(model.Note note) async {
    final updatedNote = note.copyWith(
      isDeleted: true,
      isPinned: false,
      isArchived: false,
      deletedAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _database.insertOrUpdateNote(updatedNote);
    await _syncNoteToFirebase(updatedNote);
  }

  Future<void> restoreNote(model.Note note) async {
    final updatedNote = note.copyWith(
      isDeleted: false,
      deletedAt: null,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _database.insertOrUpdateNote(updatedNote);
    await _syncNoteToFirebase(updatedNote);
  }

  Future<void> unarchiveNote(model.Note note) async {
    final updatedNote = note.copyWith(
      isArchived: false,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _database.insertOrUpdateNote(updatedNote);
    await _syncNoteToFirebase(updatedNote);
  }

  Future<void> permanentlyDeleteNote(model.Note note) async {
    await _database.deleteNoteById(note.noteId);
    await _deleteNoteFromFirebase(note.noteId);
  }

  Future<void> emptyTrash() async {
    final uid = _userId;
    if (uid == null) return;
    await _database.emptyTrash(uid);
  }

  Future<void> emptyArchive() async {
    final uid = _userId;
    if (uid == null) return;
    await _database.emptyArchive(uid);
  }

  Future<void> deleteOldNotes(int threshold) async {
    await _database.deleteOldNotes(threshold);
  }

  // ==================== FIRESTORE SYNC ====================

  Future<void> _syncNoteToFirebase(model.Note note) async {
    final uid = _userId;
    if (uid == null) return;

    try {
      await _firestore.collection(_userNotesPath).doc(note.noteId)
          .set(note.toFirestoreMap());
    } catch (e) {
      // Silently fail - local is primary
    }
  }

  Future<void> _deleteNoteFromFirebase(String noteId) async {
    final uid = _userId;
    if (uid == null) return;

    try {
      await _firestore.collection(_userNotesPath).doc(noteId).delete();
    } catch (e) {
      // Silently fail
    }
  }

  // Bug Fix: Implementation of Background Sync with proper subscription management
  void startFirebaseSync() {
    final uid = _userId;
    if (uid == null) return;

    // Avoid multiple subscriptions
    _syncSubscription?.cancel();

    _syncSubscription = _firestore.collection(_userNotesPath).snapshots().listen((snapshot) async {
      for (var change in snapshot.docChanges) {
        final data = change.doc.data();
        if (data == null) continue;

        final note = model.Note.fromFirestoreMap(data);

        if (change.type == DocumentChangeType.removed) {
          await _database.deleteNoteById(note.noteId);
        } else {
          // For Added or Modified, update local DB
          final localNote = await _database.getNoteById(note.noteId);
          if (localNote == null || note.updatedAt > localNote.updatedAt) {
            await _database.insertOrUpdateNote(note);
          }
        }
      }
    });
  }

  // CRITICAL FIX: Initial sync on login - fetch all notes from Firestore immediately
  Future<void> syncFromFirestoreOnLogin() async {
    final uid = _userId;
    if (uid == null) return;

    try {
      // Fetch all notes from Firestore
      final snapshot = await _firestore.collection(_userNotesPath).get();
      
      for (var doc in snapshot.docs) {
        final note = model.Note.fromFirestoreMap(doc.data());
        await _database.insertOrUpdateNote(note);
      }
      
      debugPrint('Initial sync completed: ${snapshot.docs.length} notes synced from Firestore');
    } catch (e) {
      debugPrint('Initial sync failed: $e');
    }
  }

  // Force sync from Firestore (for manual refresh)
  Future<void> forceSyncFromFirestore() async {
    final uid = _userId;
    if (uid == null) return;

    try {
      final snapshot = await _firestore.collection(_userNotesPath).get();
      
      for (var doc in snapshot.docs) {
        final note = model.Note.fromFirestoreMap(doc.data());
        await _database.insertOrUpdateNote(note);
      }
      
      debugPrint('Force sync completed: ${snapshot.docs.length} notes synced');
    } catch (e) {
      debugPrint('Force sync failed: $e');
      rethrow;
    }
  }

  void stopFirebaseSync() {
    _syncSubscription?.cancel();
    _syncSubscription = null;
  }

  Future<String> uploadImage(String noteId, String imagePath) async {
    final uid = _userId;
    if (uid == null) throw Exception('User not logged in');

    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = _storage.ref().child('notes_images/$uid/$noteId/$fileName');
    await ref.putFile(File(imagePath));
    return await ref.getDownloadURL();
  }

  // ==================== FIRESTORE LISTENER ====================

  Stream<List<model.Note>> syncFromFirebase() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);

    return _firestore.collection(_userNotesPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => model.Note.fromFirestoreMap(doc.data()))
          .toList();
    });
  }
}

// ==================== TAG OPERATIONS ====================

class NoteRepositoryExtras {
  final AppDatabase _database;

  NoteRepositoryExtras(this._database);

  Stream<List<model_tag.Tag>> getTags() => _database.getAllTags();

  Future<void> insertTag(model_tag.Tag tag) => _database.insertTag(tag);
  Future<void> updateTag(model_tag.Tag tag) => _database.updateTag(tag);
  Future<void> deleteTag(int tagId) async {
    await _database.deleteNoteTagsByTagId(tagId);
    await _database.deleteTag(tagId);
  }

  Future<void> assignTagsToNote(String noteId, List<int> tagIds) async {
    await _database.deleteTagsForNote(noteId);
    for (final tagId in tagIds) {
      await _database.insertNoteTag(noteId, tagId);
    }
  }

  Stream<List<model_tag.Tag>> getTagsForNote(String noteId) => _database.getTagsForNote(noteId);

  Future<int> getNoteCountForTag(int tagId) => _database.getNoteCountForTag(tagId);
}
