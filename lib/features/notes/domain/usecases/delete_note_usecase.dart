import 'package:note_pad/features/notes/domain/repositories/note_repository.dart';

class DeleteNoteUsecase {
  final NoteRepository repository;

  const DeleteNoteUsecase(this.repository);

  Future<void> call(String id) async {
    return repository.deleteNotes(id);
  }
}
