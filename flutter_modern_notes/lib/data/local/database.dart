import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../model/note.dart' as model;
import '../model/tag.dart' as model_tag;

part 'database.g.dart';

// ==================== TABLE DEFINITIONS ====================

@DataClassName('NoteEntity')
class Notes extends Table {
  TextColumn get noteId => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get formattedContent => text()();
  TextColumn get imageUrls => text()(); // JSON array stored as String
  TextColumn get audioPath => text().nullable()();
  IntColumn get audioDuration => integer().nullable()();
  BoolColumn get hasAudio => boolean().withDefault(const Constant(false))();
  TextColumn get sketchPath => text().nullable()();
  TextColumn get noteType => text().withDefault(const Constant('text'))();
  IntColumn get color => integer().withDefault(const Constant(0))();
  TextColumn get category => text().withDefault(const Constant('All'))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  IntColumn get deletedAt => integer().nullable()();
  BoolColumn get hasReminder => boolean().withDefault(const Constant(false))();
  IntColumn get reminderTime => integer().withDefault(const Constant(0))();
  TextColumn get reminderRepeat => text().withDefault(const Constant('None'))();
  TextColumn get reminderNote => text().withDefault(const Constant(''))();
  BoolColumn get isBold => boolean().withDefault(const Constant(false))();
  BoolColumn get isItalic => boolean().withDefault(const Constant(false))();
  BoolColumn get isUnderline => boolean().withDefault(const Constant(false))();
  BoolColumn get isStrikethrough => boolean().withDefault(const Constant(false))();
  TextColumn get textAlign => text().withDefault(const Constant('left'))();

  @override
  Set<Column> get primaryKey => {noteId};
}

@DataClassName('TagEntity')
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get color => integer()();
}

class NoteTags extends Table {
  TextColumn get noteId => text()();
  IntColumn get tagId => integer()();

  @override
  Set<Column> get primaryKey => {noteId, tagId};
}

// ==================== DATABASE CLASS ====================

@DriftDatabase(tables: [Notes, Tags, NoteTags])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.addColumn(notes, notes.isBold);
          await migrator.addColumn(notes, notes.isItalic);
          await migrator.addColumn(notes, notes.isUnderline);
          await migrator.addColumn(notes, notes.isStrikethrough);
          await migrator.addColumn(notes, notes.textAlign);
        }
      },
    );
  }

  // ==================== NOTE OPERATIONS ====================

  Stream<List<model.Note>> getAllNotes(String userId) {
    return (select(notes)
          ..where((n) => n.userId.equals(userId) & n.isDeleted.equals(false) & n.isArchived.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.isPinned), (n) => OrderingTerm.desc(n.updatedAt)]))
        .watch()
        .map((rows) => rows.map((row) => _noteFromRow(row)).toList());
  }

  Stream<List<model.Note>> getArchivedNotes(String userId) {
    return (select(notes)
          ..where((n) => n.userId.equals(userId) & n.isDeleted.equals(false) & n.isArchived.equals(true))
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
        .watch()
        .map((rows) => rows.map((row) => _noteFromRow(row)).toList());
  }

  Stream<List<model.Note>> getDeletedNotes(String userId) {
    return (select(notes)
          ..where((n) => n.userId.equals(userId) & n.isDeleted.equals(true))
          ..orderBy([(n) => OrderingTerm.desc(n.deletedAt)]))
        .watch()
        .map((rows) => rows.map((row) => _noteFromRow(row)).toList());
  }

  Future<model.Note?> getNoteById(String noteId) async {
    final row = await (select(notes)..where((n) => n.noteId.equals(noteId))).getSingleOrNull();
    return row != null ? _noteFromRow(row) : null;
  }

  Future<void> insertOrUpdateNote(model.Note note) async {
    await into(notes).insertOnConflictUpdate(
      NotesCompanion.insert(
        noteId: note.noteId,
        userId: note.userId,
        title: note.title,
        content: note.content,
        formattedContent: note.formattedContent,
        imageUrls: _encodeImageUrls(note.imageUrls),
        audioPath: Value(note.audioPath),
        audioDuration: Value(note.audioDuration),
        hasAudio: Value(note.hasAudio),
        sketchPath: Value(note.sketchPath),
        noteType: Value(note.noteType.name),
        color: Value(note.color),
        category: Value(note.category),
        createdAt: note.createdAt,
        updatedAt: note.updatedAt,
        isPinned: Value(note.isPinned),
        isDeleted: Value(note.isDeleted),
        isArchived: Value(note.isArchived),
        deletedAt: Value(note.deletedAt),
        hasReminder: Value(note.hasReminder),
        reminderTime: Value(note.reminderTime),
        reminderRepeat: Value(note.reminderRepeat),
        reminderNote: Value(note.reminderNote),
        isBold: Value(note.isBold),
        isItalic: Value(note.isItalic),
        isUnderline: Value(note.isUnderline),
        isStrikethrough: Value(note.isStrikethrough),
        textAlign: Value(note.textAlign),
      ),
    );
  }

  Future<void> deleteNoteById(String noteId) async {
    await (delete(notes)..where((n) => n.noteId.equals(noteId))).go();
  }

  Future<void> deleteOldNotes(int threshold) async {
    await (delete(notes)
          ..where((n) => n.isDeleted.equals(true) & n.deletedAt.isSmallerThanValue(threshold)))
        .go();
  }

  Future<void> emptyTrash(String userId) async {
    await (delete(notes)
          ..where((n) => n.userId.equals(userId) & n.isDeleted.equals(true)))
        .go();
  }

  Future<void> emptyArchive(String userId) async {
    await (delete(notes)
          ..where((n) => n.userId.equals(userId) & n.isArchived.equals(true)))
        .go();
  }

  // ==================== TAG OPERATIONS ====================

  Stream<List<model_tag.Tag>> getAllTags() {
    return (select(tags)..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch()
        .map((rows) => rows.map((row) => model_tag.Tag(id: row.id, name: row.name, color: row.color)).toList());
  }

  Future<void> insertTag(model_tag.Tag tag) async {
    await into(tags).insert(TagsCompanion.insert(name: tag.name, color: tag.color));
  }

  Future<void> updateTag(model_tag.Tag tag) async {
    await (update(tags)..where((t) => t.id.equals(tag.id)))
        .write(TagsCompanion(name: Value(tag.name), color: Value(tag.color)));
  }

  Future<void> deleteTag(int tagId) async {
    await (delete(tags)..where((t) => t.id.equals(tagId))).go();
  }

  // ==================== NOTE-TAG OPERATIONS ====================

  Future<void> insertNoteTag(String noteId, int tagId) async {
    await into(noteTags).insert(
      NoteTagsCompanion.insert(noteId: noteId, tagId: tagId),
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<void> deleteTagsForNote(String noteId) async {
    await (delete(noteTags)..where((nt) => nt.noteId.equals(noteId))).go();
  }

  Future<void> deleteNoteTagsByTagId(int tagId) async {
    await (delete(noteTags)..where((nt) => nt.tagId.equals(tagId))).go();
  }

  Stream<List<model.Note>> getNotesByTag(int tagId, String userId) {
    final query = select(notes).join([
      innerJoin(noteTags, noteTags.noteId.equalsExp(notes.noteId)),
    ])
      ..where(noteTags.tagId.equals(tagId) & notes.userId.equals(userId) & notes.isDeleted.equals(false) & notes.isArchived.equals(false))
      ..orderBy([OrderingTerm.desc(notes.isPinned), OrderingTerm.desc(notes.updatedAt)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final noteRow = row.readTable(notes);
        return _noteFromRow(noteRow);
      }).toList();
    });
  }

  Stream<List<model_tag.Tag>> getTagsForNote(String noteId) {
    final query = select(tags).join([
      innerJoin(noteTags, noteTags.tagId.equalsExp(tags.id)),
    ])
      ..where(noteTags.noteId.equals(noteId));

    return query.watch().map((rows) {
      return rows.map((row) {
        final tagRow = row.readTable(tags);
        return model_tag.Tag(id: tagRow.id, name: tagRow.name, color: tagRow.color);
      }).toList();
    });
  }

  Future<int> getNoteCountForTag(int tagId) async {
    final count = await (select(noteTags)..where((nt) => nt.tagId.equals(tagId))).get();
    return count.length;
  }

  // ==================== HELPER METHODS ====================

  model.Note _noteFromRow(NoteEntity row) {
    return model.Note(
      noteId: row.noteId,
      userId: row.userId,
      title: row.title,
      content: row.content,
      formattedContent: row.formattedContent,
      imageUrls: _decodeImageUrls(row.imageUrls),
      audioPath: row.audioPath,
      audioDuration: row.audioDuration,
      hasAudio: row.hasAudio,
      sketchPath: row.sketchPath,
      noteType: model.NoteType.values.firstWhere((e) => e.name == row.noteType, orElse: () => model.NoteType.text),
      color: row.color,
      category: row.category,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      isPinned: row.isPinned,
      isDeleted: row.isDeleted,
      isArchived: row.isArchived,
      deletedAt: row.deletedAt,
      hasReminder: row.hasReminder,
      reminderTime: row.reminderTime,
      reminderRepeat: row.reminderRepeat,
      reminderNote: row.reminderNote,
      isBold: row.isBold,
      isItalic: row.isItalic,
      isUnderline: row.isUnderline,
      isStrikethrough: row.isStrikethrough,
      textAlign: row.textAlign,
    );
  }

  String _encodeImageUrls(List<String> urls) {
    return jsonEncode(urls);
  }

  List<String> _decodeImageUrls(String encoded) {
    if (encoded.isEmpty) return [];
    try {
      return (jsonDecode(encoded) as List).cast<String>();
    } catch (e) {
      return [];
    }
  }

  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(noteTags).go();
      await delete(tags).go();
      await delete(notes).go();
    });
  }
}

// ==================== OPEN CONNECTION ====================

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'modern_notes.db'));
    return NativeDatabase.createInBackground(file);
  });
}
