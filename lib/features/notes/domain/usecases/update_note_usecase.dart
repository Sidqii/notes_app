import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/domain/repositories/note_repository.dart';

class UpdateNoteUsecase {
  final NoteRepository repository;

  const UpdateNoteUsecase(this.repository);

  Future<void> call(NoteEntity note) async {
    return repository.updateNotes(note);
  }
}
