import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/collaboration_models.dart';

class CollaborationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // ==================== ACTIVE SESSIONS ====================

  Future<void> updateActiveSession(String deviceId, String noteId, bool isTyping, bool online) async {
    final uid = _userId;
    if (uid == null) return;

    final session = ActiveSession(
      deviceId: deviceId,
      lastActive: DateTime.now(),
      currentNote: noteId,
      isTyping: isTyping,
      online: online,
    );

    // Bug Fix: Using uid_deviceId to support multiple devices for the same user
    await _firestore.collection('activeSessions').doc('${uid}_$deviceId').set(session.toMap());
  }

  // ==================== COLLABORATIVE EDITING ====================

  Future<void> updateCursor(String noteId, Cursor cursor, Selection selection) async {
    final uid = _userId;
    if (uid == null) return;

    final collaboration = UserCollaboration(
      cursor: cursor,
      selection: selection,
      lastUpdate: DateTime.now(),
    );

    await _firestore.collection('collaborativeEditing').doc(noteId)
        .set({'activeUsers': {uid: collaboration.toMap()}}, SetOptions(merge: true));
  }

  Future<void> sendTextChange(String noteId, TextChange change) async {
    final uid = _userId;
    if (uid == null) return;

    final finalChange = TextChange(
      userId: uid,
      type: change.type,
      position: change.position,
      text: change.text,
      timestamp: DateTime.now(),
    );

    await _firestore.collection('collaborativeEditing').doc(noteId)
        .collection('changes').add(finalChange.toMap());
  }

  Stream<List<TextChange>> observeChanges(String noteId) {
    return _firestore.collection('collaborativeEditing').doc(noteId)
        .collection('changes')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TextChange.fromMap(doc.data()))
            .toList());
  }

  // ==================== NOTIFICATIONS ====================

  Future<void> sendNotification(String targetUserId, AppNotification notification) async {
    final docRef = await _firestore.collection('notifications').doc(targetUserId)
        .collection('userNotifications').add(notification.toMap());
    
    await _firestore.collection('notifications').doc(targetUserId)
        .collection('userNotifications').doc(docRef.id)
        .update({'notificationId': docRef.id});
  }

  Stream<List<AppNotification>> observeNotifications() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);

    return _firestore.collection('notifications').doc(uid)
        .collection('userNotifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppNotification.fromMap(doc.data()))
            .toList());
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    final uid = _userId;
    if (uid == null) return;

    await _firestore.collection('notifications').doc(uid)
        .collection('userNotifications').doc(notificationId)
        .update({'read': true});
  }
}