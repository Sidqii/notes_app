part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent extends Equatable {
  const NotesEvent();
}

//load data
class LoadNotesEvent extends NotesEvent {
  const LoadNotesEvent();

  @override
  List<Object?> get props => [];
}

//tambah data
class AddNotesEvent extends NotesEvent {
  final NoteEntity note;

  const AddNotesEvent(this.note);

  @override
  List<Object?> get props => [note];
}

//update data
class UpdateNotesEvent extends NotesEvent {
  final NoteEntity note;

  const UpdateNotesEvent(this.note);

  @override
  List<Object?> get props => [note];
}

//hapus data
class DeleteNotesEvent extends NotesEvent {
  final String id;

  const DeleteNotesEvent(this.id);

  @override
  List<Object?> get props => [id];
}

//stream data
class StreamNotesEvent extends NotesEvent {
  final List<NoteEntity> note;

  const StreamNotesEvent(this.note);

  @override
  List<Object?> get props => [note];
}

//error event
class ErrorNotesEvent extends NotesEvent {
  final String message;

  const ErrorNotesEvent(this.message);

  @override
  List<Object?> get props => [message];
}
