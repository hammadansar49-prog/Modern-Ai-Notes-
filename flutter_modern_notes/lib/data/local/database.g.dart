// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $NotesTable extends Notes with TableInfo<$NotesTable, NoteEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _formattedContentMeta =
      const VerificationMeta('formattedContent');
  @override
  late final GeneratedColumn<String> formattedContent = GeneratedColumn<String>(
      'formatted_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlsMeta =
      const VerificationMeta('imageUrls');
  @override
  late final GeneratedColumn<String> imageUrls = GeneratedColumn<String>(
      'image_urls', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _audioDurationMeta =
      const VerificationMeta('audioDuration');
  @override
  late final GeneratedColumn<int> audioDuration = GeneratedColumn<int>(
      'audio_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hasAudioMeta =
      const VerificationMeta('hasAudio');
  @override
  late final GeneratedColumn<bool> hasAudio = GeneratedColumn<bool>(
      'has_audio', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_audio" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sketchPathMeta =
      const VerificationMeta('sketchPath');
  @override
  late final GeneratedColumn<String> sketchPath = GeneratedColumn<String>(
      'sketch_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteTypeMeta =
      const VerificationMeta('noteType');
  @override
  late final GeneratedColumn<String> noteType = GeneratedColumn<String>(
      'note_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('text'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('All'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hasReminderMeta =
      const VerificationMeta('hasReminder');
  @override
  late final GeneratedColumn<bool> hasReminder = GeneratedColumn<bool>(
      'has_reminder', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_reminder" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _reminderTimeMeta =
      const VerificationMeta('reminderTime');
  @override
  late final GeneratedColumn<int> reminderTime = GeneratedColumn<int>(
      'reminder_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _reminderRepeatMeta =
      const VerificationMeta('reminderRepeat');
  @override
  late final GeneratedColumn<String> reminderRepeat = GeneratedColumn<String>(
      'reminder_repeat', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('None'));
  static const VerificationMeta _reminderNoteMeta =
      const VerificationMeta('reminderNote');
  @override
  late final GeneratedColumn<String> reminderNote = GeneratedColumn<String>(
      'reminder_note', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isBoldMeta = const VerificationMeta('isBold');
  @override
  late final GeneratedColumn<bool> isBold = GeneratedColumn<bool>(
      'is_bold', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_bold" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isItalicMeta =
      const VerificationMeta('isItalic');
  @override
  late final GeneratedColumn<bool> isItalic = GeneratedColumn<bool>(
      'is_italic', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_italic" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isUnderlineMeta =
      const VerificationMeta('isUnderline');
  @override
  late final GeneratedColumn<bool> isUnderline = GeneratedColumn<bool>(
      'is_underline', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_underline" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isStrikethroughMeta =
      const VerificationMeta('isStrikethrough');
  @override
  late final GeneratedColumn<bool> isStrikethrough = GeneratedColumn<bool>(
      'is_strikethrough', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_strikethrough" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _textAlignMeta =
      const VerificationMeta('textAlign');
  @override
  late final GeneratedColumn<String> textAlign = GeneratedColumn<String>(
      'text_align', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('left'));
  @override
  List<GeneratedColumn> get $columns => [
        noteId,
        userId,
        title,
        content,
        formattedContent,
        imageUrls,
        audioPath,
        audioDuration,
        hasAudio,
        sketchPath,
        noteType,
        color,
        category,
        createdAt,
        updatedAt,
        isPinned,
        isDeleted,
        isArchived,
        deletedAt,
        hasReminder,
        reminderTime,
        reminderRepeat,
        reminderNote,
        isBold,
        isItalic,
        isUnderline,
        isStrikethrough,
        textAlign
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<NoteEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('formatted_content')) {
      context.handle(
          _formattedContentMeta,
          formattedContent.isAcceptableOrUnknown(
              data['formatted_content']!, _formattedContentMeta));
    } else if (isInserting) {
      context.missing(_formattedContentMeta);
    }
    if (data.containsKey('image_urls')) {
      context.handle(_imageUrlsMeta,
          imageUrls.isAcceptableOrUnknown(data['image_urls']!, _imageUrlsMeta));
    } else if (isInserting) {
      context.missing(_imageUrlsMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    }
    if (data.containsKey('audio_duration')) {
      context.handle(
          _audioDurationMeta,
          audioDuration.isAcceptableOrUnknown(
              data['audio_duration']!, _audioDurationMeta));
    }
    if (data.containsKey('has_audio')) {
      context.handle(_hasAudioMeta,
          hasAudio.isAcceptableOrUnknown(data['has_audio']!, _hasAudioMeta));
    }
    if (data.containsKey('sketch_path')) {
      context.handle(
          _sketchPathMeta,
          sketchPath.isAcceptableOrUnknown(
              data['sketch_path']!, _sketchPathMeta));
    }
    if (data.containsKey('note_type')) {
      context.handle(_noteTypeMeta,
          noteType.isAcceptableOrUnknown(data['note_type']!, _noteTypeMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('has_reminder')) {
      context.handle(
          _hasReminderMeta,
          hasReminder.isAcceptableOrUnknown(
              data['has_reminder']!, _hasReminderMeta));
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
          _reminderTimeMeta,
          reminderTime.isAcceptableOrUnknown(
              data['reminder_time']!, _reminderTimeMeta));
    }
    if (data.containsKey('reminder_repeat')) {
      context.handle(
          _reminderRepeatMeta,
          reminderRepeat.isAcceptableOrUnknown(
              data['reminder_repeat']!, _reminderRepeatMeta));
    }
    if (data.containsKey('reminder_note')) {
      context.handle(
          _reminderNoteMeta,
          reminderNote.isAcceptableOrUnknown(
              data['reminder_note']!, _reminderNoteMeta));
    }
    if (data.containsKey('is_bold')) {
      context.handle(_isBoldMeta,
          isBold.isAcceptableOrUnknown(data['is_bold']!, _isBoldMeta));
    }
    if (data.containsKey('is_italic')) {
      context.handle(_isItalicMeta,
          isItalic.isAcceptableOrUnknown(data['is_italic']!, _isItalicMeta));
    }
    if (data.containsKey('is_underline')) {
      context.handle(
          _isUnderlineMeta,
          isUnderline.isAcceptableOrUnknown(
              data['is_underline']!, _isUnderlineMeta));
    }
    if (data.containsKey('is_strikethrough')) {
      context.handle(
          _isStrikethroughMeta,
          isStrikethrough.isAcceptableOrUnknown(
              data['is_strikethrough']!, _isStrikethroughMeta));
    }
    if (data.containsKey('text_align')) {
      context.handle(_textAlignMeta,
          textAlign.isAcceptableOrUnknown(data['text_align']!, _textAlignMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {noteId};
  @override
  NoteEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteEntity(
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      formattedContent: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}formatted_content'])!,
      imageUrls: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_urls'])!,
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path']),
      audioDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}audio_duration']),
      hasAudio: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_audio'])!,
      sketchPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sketch_path']),
      noteType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_type'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
      hasReminder: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_reminder'])!,
      reminderTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reminder_time'])!,
      reminderRepeat: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reminder_repeat'])!,
      reminderNote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_note'])!,
      isBold: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_bold'])!,
      isItalic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_italic'])!,
      isUnderline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_underline'])!,
      isStrikethrough: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_strikethrough'])!,
      textAlign: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_align'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NoteEntity extends DataClass implements Insertable<NoteEntity> {
  final String noteId;
  final String userId;
  final String title;
  final String content;
  final String formattedContent;
  final String imageUrls;
  final String? audioPath;
  final int? audioDuration;
  final bool hasAudio;
  final String? sketchPath;
  final String noteType;
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
  const NoteEntity(
      {required this.noteId,
      required this.userId,
      required this.title,
      required this.content,
      required this.formattedContent,
      required this.imageUrls,
      this.audioPath,
      this.audioDuration,
      required this.hasAudio,
      this.sketchPath,
      required this.noteType,
      required this.color,
      required this.category,
      required this.createdAt,
      required this.updatedAt,
      required this.isPinned,
      required this.isDeleted,
      required this.isArchived,
      this.deletedAt,
      required this.hasReminder,
      required this.reminderTime,
      required this.reminderRepeat,
      required this.reminderNote,
      required this.isBold,
      required this.isItalic,
      required this.isUnderline,
      required this.isStrikethrough,
      required this.textAlign});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['note_id'] = Variable<String>(noteId);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['formatted_content'] = Variable<String>(formattedContent);
    map['image_urls'] = Variable<String>(imageUrls);
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    if (!nullToAbsent || audioDuration != null) {
      map['audio_duration'] = Variable<int>(audioDuration);
    }
    map['has_audio'] = Variable<bool>(hasAudio);
    if (!nullToAbsent || sketchPath != null) {
      map['sketch_path'] = Variable<String>(sketchPath);
    }
    map['note_type'] = Variable<String>(noteType);
    map['color'] = Variable<int>(color);
    map['category'] = Variable<String>(category);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_archived'] = Variable<bool>(isArchived);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    map['has_reminder'] = Variable<bool>(hasReminder);
    map['reminder_time'] = Variable<int>(reminderTime);
    map['reminder_repeat'] = Variable<String>(reminderRepeat);
    map['reminder_note'] = Variable<String>(reminderNote);
    map['is_bold'] = Variable<bool>(isBold);
    map['is_italic'] = Variable<bool>(isItalic);
    map['is_underline'] = Variable<bool>(isUnderline);
    map['is_strikethrough'] = Variable<bool>(isStrikethrough);
    map['text_align'] = Variable<String>(textAlign);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      noteId: Value(noteId),
      userId: Value(userId),
      title: Value(title),
      content: Value(content),
      formattedContent: Value(formattedContent),
      imageUrls: Value(imageUrls),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
      audioDuration: audioDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(audioDuration),
      hasAudio: Value(hasAudio),
      sketchPath: sketchPath == null && nullToAbsent
          ? const Value.absent()
          : Value(sketchPath),
      noteType: Value(noteType),
      color: Value(color),
      category: Value(category),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isPinned: Value(isPinned),
      isDeleted: Value(isDeleted),
      isArchived: Value(isArchived),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      hasReminder: Value(hasReminder),
      reminderTime: Value(reminderTime),
      reminderRepeat: Value(reminderRepeat),
      reminderNote: Value(reminderNote),
      isBold: Value(isBold),
      isItalic: Value(isItalic),
      isUnderline: Value(isUnderline),
      isStrikethrough: Value(isStrikethrough),
      textAlign: Value(textAlign),
    );
  }

  factory NoteEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteEntity(
      noteId: serializer.fromJson<String>(json['noteId']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      formattedContent: serializer.fromJson<String>(json['formattedContent']),
      imageUrls: serializer.fromJson<String>(json['imageUrls']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
      audioDuration: serializer.fromJson<int?>(json['audioDuration']),
      hasAudio: serializer.fromJson<bool>(json['hasAudio']),
      sketchPath: serializer.fromJson<String?>(json['sketchPath']),
      noteType: serializer.fromJson<String>(json['noteType']),
      color: serializer.fromJson<int>(json['color']),
      category: serializer.fromJson<String>(json['category']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
      hasReminder: serializer.fromJson<bool>(json['hasReminder']),
      reminderTime: serializer.fromJson<int>(json['reminderTime']),
      reminderRepeat: serializer.fromJson<String>(json['reminderRepeat']),
      reminderNote: serializer.fromJson<String>(json['reminderNote']),
      isBold: serializer.fromJson<bool>(json['isBold']),
      isItalic: serializer.fromJson<bool>(json['isItalic']),
      isUnderline: serializer.fromJson<bool>(json['isUnderline']),
      isStrikethrough: serializer.fromJson<bool>(json['isStrikethrough']),
      textAlign: serializer.fromJson<String>(json['textAlign']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'noteId': serializer.toJson<String>(noteId),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'formattedContent': serializer.toJson<String>(formattedContent),
      'imageUrls': serializer.toJson<String>(imageUrls),
      'audioPath': serializer.toJson<String?>(audioPath),
      'audioDuration': serializer.toJson<int?>(audioDuration),
      'hasAudio': serializer.toJson<bool>(hasAudio),
      'sketchPath': serializer.toJson<String?>(sketchPath),
      'noteType': serializer.toJson<String>(noteType),
      'color': serializer.toJson<int>(color),
      'category': serializer.toJson<String>(category),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'isPinned': serializer.toJson<bool>(isPinned),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isArchived': serializer.toJson<bool>(isArchived),
      'deletedAt': serializer.toJson<int?>(deletedAt),
      'hasReminder': serializer.toJson<bool>(hasReminder),
      'reminderTime': serializer.toJson<int>(reminderTime),
      'reminderRepeat': serializer.toJson<String>(reminderRepeat),
      'reminderNote': serializer.toJson<String>(reminderNote),
      'isBold': serializer.toJson<bool>(isBold),
      'isItalic': serializer.toJson<bool>(isItalic),
      'isUnderline': serializer.toJson<bool>(isUnderline),
      'isStrikethrough': serializer.toJson<bool>(isStrikethrough),
      'textAlign': serializer.toJson<String>(textAlign),
    };
  }

  NoteEntity copyWith(
          {String? noteId,
          String? userId,
          String? title,
          String? content,
          String? formattedContent,
          String? imageUrls,
          Value<String?> audioPath = const Value.absent(),
          Value<int?> audioDuration = const Value.absent(),
          bool? hasAudio,
          Value<String?> sketchPath = const Value.absent(),
          String? noteType,
          int? color,
          String? category,
          int? createdAt,
          int? updatedAt,
          bool? isPinned,
          bool? isDeleted,
          bool? isArchived,
          Value<int?> deletedAt = const Value.absent(),
          bool? hasReminder,
          int? reminderTime,
          String? reminderRepeat,
          String? reminderNote,
          bool? isBold,
          bool? isItalic,
          bool? isUnderline,
          bool? isStrikethrough,
          String? textAlign}) =>
      NoteEntity(
        noteId: noteId ?? this.noteId,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        content: content ?? this.content,
        formattedContent: formattedContent ?? this.formattedContent,
        imageUrls: imageUrls ?? this.imageUrls,
        audioPath: audioPath.present ? audioPath.value : this.audioPath,
        audioDuration:
            audioDuration.present ? audioDuration.value : this.audioDuration,
        hasAudio: hasAudio ?? this.hasAudio,
        sketchPath: sketchPath.present ? sketchPath.value : this.sketchPath,
        noteType: noteType ?? this.noteType,
        color: color ?? this.color,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isPinned: isPinned ?? this.isPinned,
        isDeleted: isDeleted ?? this.isDeleted,
        isArchived: isArchived ?? this.isArchived,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
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
  NoteEntity copyWithCompanion(NotesCompanion data) {
    return NoteEntity(
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      formattedContent: data.formattedContent.present
          ? data.formattedContent.value
          : this.formattedContent,
      imageUrls: data.imageUrls.present ? data.imageUrls.value : this.imageUrls,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      audioDuration: data.audioDuration.present
          ? data.audioDuration.value
          : this.audioDuration,
      hasAudio: data.hasAudio.present ? data.hasAudio.value : this.hasAudio,
      sketchPath:
          data.sketchPath.present ? data.sketchPath.value : this.sketchPath,
      noteType: data.noteType.present ? data.noteType.value : this.noteType,
      color: data.color.present ? data.color.value : this.color,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      hasReminder:
          data.hasReminder.present ? data.hasReminder.value : this.hasReminder,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      reminderRepeat: data.reminderRepeat.present
          ? data.reminderRepeat.value
          : this.reminderRepeat,
      reminderNote: data.reminderNote.present
          ? data.reminderNote.value
          : this.reminderNote,
      isBold: data.isBold.present ? data.isBold.value : this.isBold,
      isItalic: data.isItalic.present ? data.isItalic.value : this.isItalic,
      isUnderline:
          data.isUnderline.present ? data.isUnderline.value : this.isUnderline,
      isStrikethrough: data.isStrikethrough.present
          ? data.isStrikethrough.value
          : this.isStrikethrough,
      textAlign: data.textAlign.present ? data.textAlign.value : this.textAlign,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteEntity(')
          ..write('noteId: $noteId, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('formattedContent: $formattedContent, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('audioPath: $audioPath, ')
          ..write('audioDuration: $audioDuration, ')
          ..write('hasAudio: $hasAudio, ')
          ..write('sketchPath: $sketchPath, ')
          ..write('noteType: $noteType, ')
          ..write('color: $color, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isArchived: $isArchived, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('hasReminder: $hasReminder, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('reminderRepeat: $reminderRepeat, ')
          ..write('reminderNote: $reminderNote, ')
          ..write('isBold: $isBold, ')
          ..write('isItalic: $isItalic, ')
          ..write('isUnderline: $isUnderline, ')
          ..write('isStrikethrough: $isStrikethrough, ')
          ..write('textAlign: $textAlign')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        noteId,
        userId,
        title,
        content,
        formattedContent,
        imageUrls,
        audioPath,
        audioDuration,
        hasAudio,
        sketchPath,
        noteType,
        color,
        category,
        createdAt,
        updatedAt,
        isPinned,
        isDeleted,
        isArchived,
        deletedAt,
        hasReminder,
        reminderTime,
        reminderRepeat,
        reminderNote,
        isBold,
        isItalic,
        isUnderline,
        isStrikethrough,
        textAlign
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteEntity &&
          other.noteId == this.noteId &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.content == this.content &&
          other.formattedContent == this.formattedContent &&
          other.imageUrls == this.imageUrls &&
          other.audioPath == this.audioPath &&
          other.audioDuration == this.audioDuration &&
          other.hasAudio == this.hasAudio &&
          other.sketchPath == this.sketchPath &&
          other.noteType == this.noteType &&
          other.color == this.color &&
          other.category == this.category &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isPinned == this.isPinned &&
          other.isDeleted == this.isDeleted &&
          other.isArchived == this.isArchived &&
          other.deletedAt == this.deletedAt &&
          other.hasReminder == this.hasReminder &&
          other.reminderTime == this.reminderTime &&
          other.reminderRepeat == this.reminderRepeat &&
          other.reminderNote == this.reminderNote &&
          other.isBold == this.isBold &&
          other.isItalic == this.isItalic &&
          other.isUnderline == this.isUnderline &&
          other.isStrikethrough == this.isStrikethrough &&
          other.textAlign == this.textAlign);
}

class NotesCompanion extends UpdateCompanion<NoteEntity> {
  final Value<String> noteId;
  final Value<String> userId;
  final Value<String> title;
  final Value<String> content;
  final Value<String> formattedContent;
  final Value<String> imageUrls;
  final Value<String?> audioPath;
  final Value<int?> audioDuration;
  final Value<bool> hasAudio;
  final Value<String?> sketchPath;
  final Value<String> noteType;
  final Value<int> color;
  final Value<String> category;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<bool> isPinned;
  final Value<bool> isDeleted;
  final Value<bool> isArchived;
  final Value<int?> deletedAt;
  final Value<bool> hasReminder;
  final Value<int> reminderTime;
  final Value<String> reminderRepeat;
  final Value<String> reminderNote;
  final Value<bool> isBold;
  final Value<bool> isItalic;
  final Value<bool> isUnderline;
  final Value<bool> isStrikethrough;
  final Value<String> textAlign;
  final Value<int> rowid;
  const NotesCompanion({
    this.noteId = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.formattedContent = const Value.absent(),
    this.imageUrls = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.audioDuration = const Value.absent(),
    this.hasAudio = const Value.absent(),
    this.sketchPath = const Value.absent(),
    this.noteType = const Value.absent(),
    this.color = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.hasReminder = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.reminderRepeat = const Value.absent(),
    this.reminderNote = const Value.absent(),
    this.isBold = const Value.absent(),
    this.isItalic = const Value.absent(),
    this.isUnderline = const Value.absent(),
    this.isStrikethrough = const Value.absent(),
    this.textAlign = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String noteId,
    required String userId,
    required String title,
    required String content,
    required String formattedContent,
    required String imageUrls,
    this.audioPath = const Value.absent(),
    this.audioDuration = const Value.absent(),
    this.hasAudio = const Value.absent(),
    this.sketchPath = const Value.absent(),
    this.noteType = const Value.absent(),
    this.color = const Value.absent(),
    this.category = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.isPinned = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.hasReminder = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.reminderRepeat = const Value.absent(),
    this.reminderNote = const Value.absent(),
    this.isBold = const Value.absent(),
    this.isItalic = const Value.absent(),
    this.isUnderline = const Value.absent(),
    this.isStrikethrough = const Value.absent(),
    this.textAlign = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : noteId = Value(noteId),
        userId = Value(userId),
        title = Value(title),
        content = Value(content),
        formattedContent = Value(formattedContent),
        imageUrls = Value(imageUrls),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<NoteEntity> custom({
    Expression<String>? noteId,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? formattedContent,
    Expression<String>? imageUrls,
    Expression<String>? audioPath,
    Expression<int>? audioDuration,
    Expression<bool>? hasAudio,
    Expression<String>? sketchPath,
    Expression<String>? noteType,
    Expression<int>? color,
    Expression<String>? category,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<bool>? isPinned,
    Expression<bool>? isDeleted,
    Expression<bool>? isArchived,
    Expression<int>? deletedAt,
    Expression<bool>? hasReminder,
    Expression<int>? reminderTime,
    Expression<String>? reminderRepeat,
    Expression<String>? reminderNote,
    Expression<bool>? isBold,
    Expression<bool>? isItalic,
    Expression<bool>? isUnderline,
    Expression<bool>? isStrikethrough,
    Expression<String>? textAlign,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (noteId != null) 'note_id': noteId,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (formattedContent != null) 'formatted_content': formattedContent,
      if (imageUrls != null) 'image_urls': imageUrls,
      if (audioPath != null) 'audio_path': audioPath,
      if (audioDuration != null) 'audio_duration': audioDuration,
      if (hasAudio != null) 'has_audio': hasAudio,
      if (sketchPath != null) 'sketch_path': sketchPath,
      if (noteType != null) 'note_type': noteType,
      if (color != null) 'color': color,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isPinned != null) 'is_pinned': isPinned,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isArchived != null) 'is_archived': isArchived,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (hasReminder != null) 'has_reminder': hasReminder,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (reminderRepeat != null) 'reminder_repeat': reminderRepeat,
      if (reminderNote != null) 'reminder_note': reminderNote,
      if (isBold != null) 'is_bold': isBold,
      if (isItalic != null) 'is_italic': isItalic,
      if (isUnderline != null) 'is_underline': isUnderline,
      if (isStrikethrough != null) 'is_strikethrough': isStrikethrough,
      if (textAlign != null) 'text_align': textAlign,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? noteId,
      Value<String>? userId,
      Value<String>? title,
      Value<String>? content,
      Value<String>? formattedContent,
      Value<String>? imageUrls,
      Value<String?>? audioPath,
      Value<int?>? audioDuration,
      Value<bool>? hasAudio,
      Value<String?>? sketchPath,
      Value<String>? noteType,
      Value<int>? color,
      Value<String>? category,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<bool>? isPinned,
      Value<bool>? isDeleted,
      Value<bool>? isArchived,
      Value<int?>? deletedAt,
      Value<bool>? hasReminder,
      Value<int>? reminderTime,
      Value<String>? reminderRepeat,
      Value<String>? reminderNote,
      Value<bool>? isBold,
      Value<bool>? isItalic,
      Value<bool>? isUnderline,
      Value<bool>? isStrikethrough,
      Value<String>? textAlign,
      Value<int>? rowid}) {
    return NotesCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (formattedContent.present) {
      map['formatted_content'] = Variable<String>(formattedContent.value);
    }
    if (imageUrls.present) {
      map['image_urls'] = Variable<String>(imageUrls.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (audioDuration.present) {
      map['audio_duration'] = Variable<int>(audioDuration.value);
    }
    if (hasAudio.present) {
      map['has_audio'] = Variable<bool>(hasAudio.value);
    }
    if (sketchPath.present) {
      map['sketch_path'] = Variable<String>(sketchPath.value);
    }
    if (noteType.present) {
      map['note_type'] = Variable<String>(noteType.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (hasReminder.present) {
      map['has_reminder'] = Variable<bool>(hasReminder.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<int>(reminderTime.value);
    }
    if (reminderRepeat.present) {
      map['reminder_repeat'] = Variable<String>(reminderRepeat.value);
    }
    if (reminderNote.present) {
      map['reminder_note'] = Variable<String>(reminderNote.value);
    }
    if (isBold.present) {
      map['is_bold'] = Variable<bool>(isBold.value);
    }
    if (isItalic.present) {
      map['is_italic'] = Variable<bool>(isItalic.value);
    }
    if (isUnderline.present) {
      map['is_underline'] = Variable<bool>(isUnderline.value);
    }
    if (isStrikethrough.present) {
      map['is_strikethrough'] = Variable<bool>(isStrikethrough.value);
    }
    if (textAlign.present) {
      map['text_align'] = Variable<String>(textAlign.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('noteId: $noteId, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('formattedContent: $formattedContent, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('audioPath: $audioPath, ')
          ..write('audioDuration: $audioDuration, ')
          ..write('hasAudio: $hasAudio, ')
          ..write('sketchPath: $sketchPath, ')
          ..write('noteType: $noteType, ')
          ..write('color: $color, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isPinned: $isPinned, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isArchived: $isArchived, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('hasReminder: $hasReminder, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('reminderRepeat: $reminderRepeat, ')
          ..write('reminderNote: $reminderNote, ')
          ..write('isBold: $isBold, ')
          ..write('isItalic: $isItalic, ')
          ..write('isUnderline: $isUnderline, ')
          ..write('isStrikethrough: $isStrikethrough, ')
          ..write('textAlign: $textAlign, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, TagEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<TagEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class TagEntity extends DataClass implements Insertable<TagEntity> {
  final int id;
  final String name;
  final int color;
  const TagEntity({required this.id, required this.name, required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<int>(color);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
    );
  }

  factory TagEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
    };
  }

  TagEntity copyWith({int? id, String? name, int? color}) => TagEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
      );
  TagEntity copyWithCompanion(TagsCompanion data) {
    return TagEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color);
}

class TagsCompanion extends UpdateCompanion<TagEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int color,
  })  : name = Value(name),
        color = Value(color);
  static Insertable<TagEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  TagsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? color}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $NoteTagsTable extends NoteTags
    with TableInfo<$NoteTagsTable, model_tag.NoteTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [noteId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_tags';
  @override
  VerificationContext validateIntegrity(Insertable<model_tag.NoteTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {noteId, tagId};
  @override
  model_tag.NoteTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return model_tag.NoteTag(
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $NoteTagsTable createAlias(String alias) {
    return $NoteTagsTable(attachedDatabase, alias);
  }
}

class NoteTag extends DataClass implements Insertable<model_tag.NoteTag> {
  final String noteId;
  final int tagId;
  const NoteTag({required this.noteId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['note_id'] = Variable<String>(noteId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  NoteTagsCompanion toCompanion(bool nullToAbsent) {
    return NoteTagsCompanion(
      noteId: Value(noteId),
      tagId: Value(tagId),
    );
  }

  factory NoteTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteTag(
      noteId: serializer.fromJson<String>(json['noteId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'noteId': serializer.toJson<String>(noteId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  model_tag.NoteTag copyWith({String? noteId, int? tagId}) => model_tag.NoteTag(
        noteId: noteId ?? this.noteId,
        tagId: tagId ?? this.tagId,
      );
  NoteTag copyWithCompanion(NoteTagsCompanion data) {
    return NoteTag(
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteTag(')
          ..write('noteId: $noteId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(noteId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is model_tag.NoteTag &&
          other.noteId == this.noteId &&
          other.tagId == this.tagId);
}

class NoteTagsCompanion extends UpdateCompanion<model_tag.NoteTag> {
  final Value<String> noteId;
  final Value<int> tagId;
  final Value<int> rowid;
  const NoteTagsCompanion({
    this.noteId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoteTagsCompanion.insert({
    required String noteId,
    required int tagId,
    this.rowid = const Value.absent(),
  })  : noteId = Value(noteId),
        tagId = Value(tagId);
  static Insertable<model_tag.NoteTag> custom({
    Expression<String>? noteId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (noteId != null) 'note_id': noteId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoteTagsCompanion copyWith(
      {Value<String>? noteId, Value<int>? tagId, Value<int>? rowid}) {
    return NoteTagsCompanion(
      noteId: noteId ?? this.noteId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteTagsCompanion(')
          ..write('noteId: $noteId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $NoteTagsTable noteTags = $NoteTagsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes, tags, noteTags];
}

typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  required String noteId,
  required String userId,
  required String title,
  required String content,
  required String formattedContent,
  required String imageUrls,
  Value<String?> audioPath,
  Value<int?> audioDuration,
  Value<bool> hasAudio,
  Value<String?> sketchPath,
  Value<String> noteType,
  Value<int> color,
  Value<String> category,
  required int createdAt,
  required int updatedAt,
  Value<bool> isPinned,
  Value<bool> isDeleted,
  Value<bool> isArchived,
  Value<int?> deletedAt,
  Value<bool> hasReminder,
  Value<int> reminderTime,
  Value<String> reminderRepeat,
  Value<String> reminderNote,
  Value<bool> isBold,
  Value<bool> isItalic,
  Value<bool> isUnderline,
  Value<bool> isStrikethrough,
  Value<String> textAlign,
  Value<int> rowid,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<String> noteId,
  Value<String> userId,
  Value<String> title,
  Value<String> content,
  Value<String> formattedContent,
  Value<String> imageUrls,
  Value<String?> audioPath,
  Value<int?> audioDuration,
  Value<bool> hasAudio,
  Value<String?> sketchPath,
  Value<String> noteType,
  Value<int> color,
  Value<String> category,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<bool> isPinned,
  Value<bool> isDeleted,
  Value<bool> isArchived,
  Value<int?> deletedAt,
  Value<bool> hasReminder,
  Value<int> reminderTime,
  Value<String> reminderRepeat,
  Value<String> reminderNote,
  Value<bool> isBold,
  Value<bool> isItalic,
  Value<bool> isUnderline,
  Value<bool> isStrikethrough,
  Value<String> textAlign,
  Value<int> rowid,
});

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formattedContent => $composableBuilder(
      column: $table.formattedContent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrls => $composableBuilder(
      column: $table.imageUrls, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get audioDuration => $composableBuilder(
      column: $table.audioDuration, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasAudio => $composableBuilder(
      column: $table.hasAudio, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sketchPath => $composableBuilder(
      column: $table.sketchPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get noteType => $composableBuilder(
      column: $table.noteType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasReminder => $composableBuilder(
      column: $table.hasReminder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderRepeat => $composableBuilder(
      column: $table.reminderRepeat,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderNote => $composableBuilder(
      column: $table.reminderNote, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isBold => $composableBuilder(
      column: $table.isBold, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isItalic => $composableBuilder(
      column: $table.isItalic, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isUnderline => $composableBuilder(
      column: $table.isUnderline, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isStrikethrough => $composableBuilder(
      column: $table.isStrikethrough,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textAlign => $composableBuilder(
      column: $table.textAlign, builder: (column) => ColumnFilters(column));
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formattedContent => $composableBuilder(
      column: $table.formattedContent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrls => $composableBuilder(
      column: $table.imageUrls, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get audioDuration => $composableBuilder(
      column: $table.audioDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasAudio => $composableBuilder(
      column: $table.hasAudio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sketchPath => $composableBuilder(
      column: $table.sketchPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get noteType => $composableBuilder(
      column: $table.noteType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasReminder => $composableBuilder(
      column: $table.hasReminder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reminderTime => $composableBuilder(
      column: $table.reminderTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderRepeat => $composableBuilder(
      column: $table.reminderRepeat,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderNote => $composableBuilder(
      column: $table.reminderNote,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isBold => $composableBuilder(
      column: $table.isBold, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isItalic => $composableBuilder(
      column: $table.isItalic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isUnderline => $composableBuilder(
      column: $table.isUnderline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isStrikethrough => $composableBuilder(
      column: $table.isStrikethrough,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textAlign => $composableBuilder(
      column: $table.textAlign, builder: (column) => ColumnOrderings(column));
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get formattedContent => $composableBuilder(
      column: $table.formattedContent, builder: (column) => column);

  GeneratedColumn<String> get imageUrls =>
      $composableBuilder(column: $table.imageUrls, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<int> get audioDuration => $composableBuilder(
      column: $table.audioDuration, builder: (column) => column);

  GeneratedColumn<bool> get hasAudio =>
      $composableBuilder(column: $table.hasAudio, builder: (column) => column);

  GeneratedColumn<String> get sketchPath => $composableBuilder(
      column: $table.sketchPath, builder: (column) => column);

  GeneratedColumn<String> get noteType =>
      $composableBuilder(column: $table.noteType, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<bool> get hasReminder => $composableBuilder(
      column: $table.hasReminder, builder: (column) => column);

  GeneratedColumn<int> get reminderTime => $composableBuilder(
      column: $table.reminderTime, builder: (column) => column);

  GeneratedColumn<String> get reminderRepeat => $composableBuilder(
      column: $table.reminderRepeat, builder: (column) => column);

  GeneratedColumn<String> get reminderNote => $composableBuilder(
      column: $table.reminderNote, builder: (column) => column);

  GeneratedColumn<bool> get isBold =>
      $composableBuilder(column: $table.isBold, builder: (column) => column);

  GeneratedColumn<bool> get isItalic =>
      $composableBuilder(column: $table.isItalic, builder: (column) => column);

  GeneratedColumn<bool> get isUnderline => $composableBuilder(
      column: $table.isUnderline, builder: (column) => column);

  GeneratedColumn<bool> get isStrikethrough => $composableBuilder(
      column: $table.isStrikethrough, builder: (column) => column);

  GeneratedColumn<String> get textAlign =>
      $composableBuilder(column: $table.textAlign, builder: (column) => column);
}

class $$NotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotesTable,
    NoteEntity,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (NoteEntity, BaseReferences<_$AppDatabase, $NotesTable, NoteEntity>),
    NoteEntity,
    PrefetchHooks Function()> {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> noteId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> formattedContent = const Value.absent(),
            Value<String> imageUrls = const Value.absent(),
            Value<String?> audioPath = const Value.absent(),
            Value<int?> audioDuration = const Value.absent(),
            Value<bool> hasAudio = const Value.absent(),
            Value<String?> sketchPath = const Value.absent(),
            Value<String> noteType = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<bool> hasReminder = const Value.absent(),
            Value<int> reminderTime = const Value.absent(),
            Value<String> reminderRepeat = const Value.absent(),
            Value<String> reminderNote = const Value.absent(),
            Value<bool> isBold = const Value.absent(),
            Value<bool> isItalic = const Value.absent(),
            Value<bool> isUnderline = const Value.absent(),
            Value<bool> isStrikethrough = const Value.absent(),
            Value<String> textAlign = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion(
            noteId: noteId,
            userId: userId,
            title: title,
            content: content,
            formattedContent: formattedContent,
            imageUrls: imageUrls,
            audioPath: audioPath,
            audioDuration: audioDuration,
            hasAudio: hasAudio,
            sketchPath: sketchPath,
            noteType: noteType,
            color: color,
            category: category,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isPinned: isPinned,
            isDeleted: isDeleted,
            isArchived: isArchived,
            deletedAt: deletedAt,
            hasReminder: hasReminder,
            reminderTime: reminderTime,
            reminderRepeat: reminderRepeat,
            reminderNote: reminderNote,
            isBold: isBold,
            isItalic: isItalic,
            isUnderline: isUnderline,
            isStrikethrough: isStrikethrough,
            textAlign: textAlign,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String noteId,
            required String userId,
            required String title,
            required String content,
            required String formattedContent,
            required String imageUrls,
            Value<String?> audioPath = const Value.absent(),
            Value<int?> audioDuration = const Value.absent(),
            Value<bool> hasAudio = const Value.absent(),
            Value<String?> sketchPath = const Value.absent(),
            Value<String> noteType = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<String> category = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<bool> isPinned = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<bool> hasReminder = const Value.absent(),
            Value<int> reminderTime = const Value.absent(),
            Value<String> reminderRepeat = const Value.absent(),
            Value<String> reminderNote = const Value.absent(),
            Value<bool> isBold = const Value.absent(),
            Value<bool> isItalic = const Value.absent(),
            Value<bool> isUnderline = const Value.absent(),
            Value<bool> isStrikethrough = const Value.absent(),
            Value<String> textAlign = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion.insert(
            noteId: noteId,
            userId: userId,
            title: title,
            content: content,
            formattedContent: formattedContent,
            imageUrls: imageUrls,
            audioPath: audioPath,
            audioDuration: audioDuration,
            hasAudio: hasAudio,
            sketchPath: sketchPath,
            noteType: noteType,
            color: color,
            category: category,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isPinned: isPinned,
            isDeleted: isDeleted,
            isArchived: isArchived,
            deletedAt: deletedAt,
            hasReminder: hasReminder,
            reminderTime: reminderTime,
            reminderRepeat: reminderRepeat,
            reminderNote: reminderNote,
            isBold: isBold,
            isItalic: isItalic,
            isUnderline: isUnderline,
            isStrikethrough: isStrikethrough,
            textAlign: textAlign,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotesTable,
    NoteEntity,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (NoteEntity, BaseReferences<_$AppDatabase, $NotesTable, NoteEntity>),
    NoteEntity,
    PrefetchHooks Function()>;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  required String name,
  required int color,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> color,
});

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);
}

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    TagEntity,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (TagEntity, BaseReferences<_$AppDatabase, $TagsTable, TagEntity>),
    TagEntity,
    PrefetchHooks Function()> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> color = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            name: name,
            color: color,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int color,
          }) =>
              TagsCompanion.insert(
            id: id,
            name: name,
            color: color,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TagsTable,
    TagEntity,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (TagEntity, BaseReferences<_$AppDatabase, $TagsTable, TagEntity>),
    TagEntity,
    PrefetchHooks Function()>;
typedef $$NoteTagsTableCreateCompanionBuilder = NoteTagsCompanion Function({
  required String noteId,
  required int tagId,
  Value<int> rowid,
});
typedef $$NoteTagsTableUpdateCompanionBuilder = NoteTagsCompanion Function({
  Value<String> noteId,
  Value<int> tagId,
  Value<int> rowid,
});

class $$NoteTagsTableFilterComposer
    extends Composer<_$AppDatabase, $NoteTagsTable> {
  $$NoteTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));
}

class $$NoteTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $NoteTagsTable> {
  $$NoteTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));
}

class $$NoteTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NoteTagsTable> {
  $$NoteTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);
}

class $$NoteTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NoteTagsTable,
    model_tag.NoteTag,
    $$NoteTagsTableFilterComposer,
    $$NoteTagsTableOrderingComposer,
    $$NoteTagsTableAnnotationComposer,
    $$NoteTagsTableCreateCompanionBuilder,
    $$NoteTagsTableUpdateCompanionBuilder,
    (
      model_tag.NoteTag,
      BaseReferences<_$AppDatabase, $NoteTagsTable, model_tag.NoteTag>
    ),
    model_tag.NoteTag,
    PrefetchHooks Function()> {
  $$NoteTagsTableTableManager(_$AppDatabase db, $NoteTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoteTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoteTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoteTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> noteId = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteTagsCompanion(
            noteId: noteId,
            tagId: tagId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String noteId,
            required int tagId,
            Value<int> rowid = const Value.absent(),
          }) =>
              NoteTagsCompanion.insert(
            noteId: noteId,
            tagId: tagId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NoteTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NoteTagsTable,
    model_tag.NoteTag,
    $$NoteTagsTableFilterComposer,
    $$NoteTagsTableOrderingComposer,
    $$NoteTagsTableAnnotationComposer,
    $$NoteTagsTableCreateCompanionBuilder,
    $$NoteTagsTableUpdateCompanionBuilder,
    (
      model_tag.NoteTag,
      BaseReferences<_$AppDatabase, $NoteTagsTable, model_tag.NoteTag>
    ),
    model_tag.NoteTag,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$NoteTagsTableTableManager get noteTags =>
      $$NoteTagsTableTableManager(_db, _db.noteTags);
}
