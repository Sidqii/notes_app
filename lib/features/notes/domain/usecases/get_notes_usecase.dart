import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/domain/repositories/note_repository.dart';

class GetNotesUsecase {
  final NoteRepository repository;

  const GetNotesUsecase(this.repository);

  Stream<List<NoteEntity>> call() {
    return repository.getAllNotes();
  }
}
