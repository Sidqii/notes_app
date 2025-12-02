part of 'notes_bloc.dart';

@immutable
sealed class NotesState extends Equatable {
  const NotesState();
}

class NotesInitialState extends NotesState {
  const NotesInitialState();

  @override
  List<Object?> get props => [];
}

class NotesLoadingState extends NotesState {
  const NotesLoadingState();

  @override
  List<Object?> get props => [];
}

class NotesLoadedState extends NotesState {
  final List<NoteEntity> note;

  const NotesLoadedState(this.note);

  @override
  List<Object?> get props => [note];
}

class NotesErrorState extends NotesState {
  final String message;

  const NotesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
