import 'package:note_pad/features/notes/data/datasources/note_remote_datasource.dart';
import 'package:note_pad/features/notes/data/models/note_model.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDatasource remote;

  NoteRepositoryImpl(this.remote);

  @override
  Future<void> createNote(NoteEntity note) {
    final model = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      timestamp: note.timestamp,
    );

    return remote.createNote(model);
  }

  @override
  Stream<List<NoteEntity>> getAllNotes() {
    return remote.getNotes().map(
      (models) => models
          .map(
            (model) => NoteEntity(
              id: model.id,
              title: model.title,
              content: model.content,
              timestamp: model.timestamp,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> updateNotes(NoteEntity note) {
    final model = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      timestamp: note.timestamp,
    );

    return remote.updateNote(model);
  }

  @override
  Future<void> deleteNotes(String id) {
    return remote.deleteNote(id);
  }
}
