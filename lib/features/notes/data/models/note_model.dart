import 'package:flutter/material.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';

@immutable
class NoteModel extends NoteEntity {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.timestamp,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
