import 'package:flutter/foundation.dart';

@immutable
class NoteEntity {
  final String id;
  final String title;
  final String content;
  final DateTime timestamp;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });
}
