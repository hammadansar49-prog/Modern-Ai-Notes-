class Tag {
  final int id;
  final String name;
  final int color;

  Tag({
    required this.id,
    required this.name,
    required this.color,
  });

  Tag copyWith({
    int? id,
    String? name,
    int? color,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      color: map['color'] ?? 0xFF000000,
    );
  }
}

class NoteTag {
  final String noteId;
  final int tagId;

  NoteTag({
    required this.noteId,
    required this.tagId,
  });

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'tagId': tagId,
    };
  }

  factory NoteTag.fromMap(Map<String, dynamic> map) {
    return NoteTag(
      noteId: map['noteId'] ?? '',
      tagId: map['tagId'] ?? 0,
    );
  }
}