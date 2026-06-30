class ActiveSession {
  final String deviceId;
  final DateTime lastActive;
  final String currentNote;
  final bool isTyping;
  final bool online;

  ActiveSession({
    required this.deviceId,
    required this.lastActive,
    this.currentNote = '',
    this.isTyping = false,
    this.online = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'deviceId': deviceId,
      'lastActive': lastActive.millisecondsSinceEpoch,
      'currentNote': currentNote,
      'isTyping': isTyping,
      'online': online,
    };
  }

  factory ActiveSession.fromMap(Map<String, dynamic> map) {
    return ActiveSession(
      deviceId: map['deviceId'] ?? '',
      lastActive: map['lastActive'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['lastActive'])
          : DateTime.now(),
      currentNote: map['currentNote'] ?? '',
      isTyping: map['isTyping'] ?? false,
      online: map['online'] ?? false,
    );
  }
}

class UserCollaboration {
  final Cursor cursor;
  final Selection selection;
  final DateTime lastUpdate;

  UserCollaboration({
    this.cursor = const Cursor(),
    this.selection = const Selection(),
    required this.lastUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'cursor': cursor.toMap(),
      'selection': selection.toMap(),
      'lastUpdate': lastUpdate.millisecondsSinceEpoch,
    };
  }

  factory UserCollaboration.fromMap(Map<String, dynamic> map) {
    return UserCollaboration(
      cursor: map['cursor'] != null 
          ? Cursor.fromMap(Map<String, dynamic>.from(map['cursor']))
          : const Cursor(),
      selection: map['selection'] != null 
          ? Selection.fromMap(Map<String, dynamic>.from(map['selection']))
          : const Selection(),
      lastUpdate: map['lastUpdate'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['lastUpdate'])
          : DateTime.now(),
    );
  }
}

class Cursor {
  final int index;
  final int length;

  const Cursor({
    this.index = 0,
    this.length = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'length': length,
    };
  }

  factory Cursor.fromMap(Map<String, dynamic> map) {
    return Cursor(
      index: map['index'] ?? 0,
      length: map['length'] ?? 0,
    );
  }
}

class Selection {
  final int start;
  final int end;

  const Selection({
    this.start = 0,
    this.end = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
    };
  }

  factory Selection.fromMap(Map<String, dynamic> map) {
    return Selection(
      start: map['start'] ?? 0,
      end: map['end'] ?? 0,
    );
  }
}

class TextChange {
  final String userId;
  final String type;
  final int position;
  final String text;
  final DateTime timestamp;

  TextChange({
    required this.userId,
    this.type = 'insert',
    required this.position,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'position': position,
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory TextChange.fromMap(Map<String, dynamic> map) {
    return TextChange(
      userId: map['userId'] ?? '',
      type: map['type'] ?? 'insert',
      position: map['position'] ?? 0,
      text: map['text'] ?? '',
      timestamp: map['timestamp'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : DateTime.now(),
    );
  }
}

class AppNotification {
  final String notificationId;
  final String type;
  final String title;
  final String message;
  final Map<String, String> data;
  final bool read;
  final DateTime createdAt;

  AppNotification({
    required this.notificationId,
    required this.type,
    required this.title,
    required this.message,
    this.data = const {},
    this.read = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'type': type,
      'title': title,
      'message': message,
      'data': data,
      'read': read,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      notificationId: map['notificationId'] ?? '',
      type: map['type'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      data: Map<String, String>.from(map['data'] ?? {}),
      read: map['read'] ?? false,
      createdAt: map['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : DateTime.now(),
    );
  }
}