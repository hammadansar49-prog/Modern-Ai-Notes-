import 'dart:convert';

enum NoteType {
  text,
  audio,
  sketch,
  image,
}

class Note {
  final String noteId;
  final String userId;
  final String title;
  final String content;
  final String formattedContent;
  final List<String> imageUrls;
  final String? audioPath;
  final int? audioDuration;
  final bool hasAudio;
  final String? sketchPath;
  final NoteType noteType;
  final int color;
  final String category;
  final int createdAt;
  final int updatedAt;
  final bool isPinned;
  final bool isDeleted;
  final bool isArchived;
  final int? deletedAt;
  final bool hasReminder;
  final int reminderTime;
  final String reminderRepeat;
  final String reminderNote;
  final bool isBold;
  final bool isItalic;
  final bool isUnderline;
  final bool isStrikethrough;
  final String textAlign;

  Note({
    required this.noteId,
    required this.userId,
    this.title = '',
    this.content = '',
    this.formattedContent = '',
    this.imageUrls = const [],
    this.audioPath,
    this.audioDuration,
    this.hasAudio = false,
    this.sketchPath,
    this.noteType = NoteType.text,
    this.color = 0,
    this.category = 'All',
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
    this.isDeleted = false,
    this.isArchived = false,
    this.deletedAt,
    this.hasReminder = false,
    this.reminderTime = 0,
    this.reminderRepeat = 'None',
    this.reminderNote = '',
    this.isBold = false,
    this.isItalic = false,
    this.isUnderline = false,
    this.isStrikethrough = false,
    this.textAlign = 'left',
  });

  Note copyWith({
    String? noteId,
    String? userId,
    String? title,
    String? content,
    String? formattedContent,
    List<String>? imageUrls,
    String? audioPath,
    int? audioDuration,
    bool? hasAudio,
    String? sketchPath,
    NoteType? noteType,
    int? color,
    String? category,
    int? createdAt,
    int? updatedAt,
    bool? isPinned,
    bool? isDeleted,
    bool? isArchived,
    int? deletedAt,
    bool? hasReminder,
    int? reminderTime,
    String? reminderRepeat,
    String? reminderNote,
    bool? isBold,
    bool? isItalic,
    bool? isUnderline,
    bool? isStrikethrough,
    String? textAlign,
  }) {
    return Note(
      noteId: noteId ?? this.noteId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      formattedContent: formattedContent ?? this.formattedContent,
      imageUrls: imageUrls ?? this.imageUrls,
      audioPath: audioPath ?? this.audioPath,
      audioDuration: audioDuration ?? this.audioDuration,
      hasAudio: hasAudio ?? this.hasAudio,
      sketchPath: sketchPath ?? this.sketchPath,
      noteType: noteType ?? this.noteType,
      color: color ?? this.color,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      isDeleted: isDeleted ?? this.isDeleted,
      isArchived: isArchived ?? this.isArchived,
      deletedAt: deletedAt ?? this.deletedAt,
      hasReminder: hasReminder ?? this.hasReminder,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderRepeat: reminderRepeat ?? this.reminderRepeat,
      reminderNote: reminderNote ?? this.reminderNote,
      isBold: isBold ?? this.isBold,
      isItalic: isItalic ?? this.isItalic,
      isUnderline: isUnderline ?? this.isUnderline,
      isStrikethrough: isStrikethrough ?? this.isStrikethrough,
      textAlign: textAlign ?? this.textAlign,
    );
  }

  // Convert to Map for local storage (SQLite)
  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'userId': userId,
      'title': title,
      'content': content,
      'formattedContent': formattedContent,
      'imageUrls': jsonEncode(imageUrls),
      'audioPath': audioPath,
      'audioDuration': audioDuration,
      'hasAudio': hasAudio ? 1 : 0,
      'sketchPath': sketchPath,
      'noteType': noteType.name,
      'color': color,
      'category': category,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isPinned': isPinned ? 1 : 0,
      'isDeleted': isDeleted ? 1 : 0,
      'isArchived': isArchived ? 1 : 0,
      'deletedAt': deletedAt,
      'hasReminder': hasReminder ? 1 : 0,
      'reminderTime': reminderTime,
      'reminderRepeat': reminderRepeat,
      'reminderNote': reminderNote,
      'isBold': isBold ? 1 : 0,
      'isItalic': isItalic ? 1 : 0,
      'isUnderline': isUnderline ? 1 : 0,
      'isStrikethrough': isStrikethrough ? 1 : 0,
      'textAlign': textAlign,
    };
  }

  // Create from local storage Map
  factory Note.fromMap(Map<String, dynamic> map) {
    List<String> parsedImageUrls = [];
    if (map['imageUrls'] != null && map['imageUrls'].toString().isNotEmpty) {
      try {
        parsedImageUrls = List<String>.from(jsonDecode(map['imageUrls']));
      } catch (e) {
        parsedImageUrls = [];
      }
    }

    return Note(
      noteId: map['noteId'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      formattedContent: map['formattedContent'] ?? '',
      imageUrls: parsedImageUrls,
      audioPath: map['audioPath'],
      audioDuration: map['audioDuration'],
      hasAudio: map['hasAudio'] == 1,
      sketchPath: map['sketchPath'],
      noteType: NoteType.values.firstWhere(
        (e) => e.name == map['noteType'],
        orElse: () => NoteType.text,
      ),
      color: map['color'] ?? 0,
      category: map['category'] ?? 'All',
      createdAt: map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
      updatedAt: map['updatedAt'] ?? DateTime.now().millisecondsSinceEpoch,
      isPinned: map['isPinned'] == 1,
      isDeleted: map['isDeleted'] == 1,
      isArchived: map['isArchived'] == 1,
      deletedAt: map['deletedAt'],
      hasReminder: map['hasReminder'] == 1,
      reminderTime: map['reminderTime'] ?? 0,
      reminderRepeat: map['reminderRepeat'] ?? 'None',
      reminderNote: map['reminderNote'] ?? '',
      isBold: map['isBold'] == 1,
      isItalic: map['isItalic'] == 1,
      isUnderline: map['isUnderline'] == 1,
      isStrikethrough: map['isStrikethrough'] == 1,
      textAlign: map['textAlign'] ?? 'left',
    );
  }

  // Convert to Firestore Map (with Timestamp handling done by repository)
  Map<String, dynamic> toFirestoreMap() {
    return {
      'noteId': noteId,
      'userId': userId,
      'title': title,
      'content': content,
      'formattedContent': formattedContent,
      'imageUrls': imageUrls,
      'audioPath': audioPath,
      'audioDuration': audioDuration,
      'hasAudio': hasAudio,
      'sketchPath': sketchPath,
      'noteType': noteType.name,
      'color': color,
      'category': category,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isPinned': isPinned,
      'isDeleted': isDeleted,
      'isArchived': isArchived,
      'deletedAt': deletedAt,
      'hasReminder': hasReminder,
      'reminderTime': reminderTime,
      'reminderRepeat': reminderRepeat,
      'reminderNote': reminderNote,
      'isBold': isBold,
      'isItalic': isItalic,
      'isUnderline': isUnderline,
      'isStrikethrough': isStrikethrough,
      'textAlign': textAlign,
    };
  }

  // Create from Firestore Map
  factory Note.fromFirestoreMap(Map<String, dynamic> map) {
    List<String> parsedImageUrls = [];
    if (map['imageUrls'] != null) {
      try {
        parsedImageUrls = List<String>.from(map['imageUrls']);
      } catch (e) {
        parsedImageUrls = [];
      }
    }

    return Note(
      noteId: map['noteId'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      formattedContent: map['formattedContent'] ?? '',
      imageUrls: parsedImageUrls,
      audioPath: map['audioPath'],
      audioDuration: map['audioDuration'],
      hasAudio: map['hasAudio'] ?? false,
      sketchPath: map['sketchPath'],
      noteType: NoteType.values.firstWhere(
        (e) => e.name == map['noteType'],
        orElse: () => NoteType.text,
      ),
      color: map['color'] ?? 0,
      category: map['category'] ?? 'All',
      createdAt: map['createdAt'] is int 
          ? map['createdAt'] 
          : (map['createdAt']?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch),
      updatedAt: map['updatedAt'] is int 
          ? map['updatedAt'] 
          : (map['updatedAt']?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch),
      isPinned: map['isPinned'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
      isArchived: map['isArchived'] ?? false,
      deletedAt: map['deletedAt'],
      hasReminder: map['hasReminder'] ?? false,
      reminderTime: map['reminderTime'] ?? 0,
      reminderRepeat: map['reminderRepeat'] ?? 'None',
      reminderNote: map['reminderNote'] ?? '',
      isBold: map['isBold'] ?? false,
      isItalic: map['isItalic'] ?? false,
      isUnderline: map['isUnderline'] ?? false,
      isStrikethrough: map['isStrikethrough'] ?? false,
      textAlign: map['textAlign'] ?? 'left',
    );
  }
}