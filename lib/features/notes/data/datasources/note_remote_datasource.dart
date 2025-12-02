import 'package:note_pad/features/notes/data/models/note_model.dart';

abstract class NoteRemoteDatasource {
  Future<void> createNote(NoteModel note);

  Stream<List<NoteModel>> getNotes();

  Future<void> updateNote(NoteModel note);

  Future<void> deleteNote(String id);
}
