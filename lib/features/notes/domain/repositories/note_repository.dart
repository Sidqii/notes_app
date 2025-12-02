import 'package:note_pad/features/notes/domain/entities/note_entity.dart';

abstract class NoteRepository {
  Future<void> createNote(NoteEntity note);

  Stream<List<NoteEntity>> getAllNotes();

  Future<void> updateNotes(NoteEntity note);

  Future<void> deleteNotes(String id);
}
