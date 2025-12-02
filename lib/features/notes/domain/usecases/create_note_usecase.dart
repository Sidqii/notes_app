import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/domain/repositories/note_repository.dart';

class CreateNoteUsecase {
  final NoteRepository repository;

  const CreateNoteUsecase(this.repository);

  Future<void> call(NoteEntity note) async {
    return repository.createNote(note);
  }
}
