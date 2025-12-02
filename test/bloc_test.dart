import 'package:flutter_test/flutter_test.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/presentation/bloc/crud/notes_bloc.dart';

void main() {
  test('NotesEvent Equatable test', () {
    final note = NoteEntity(
      id: '1',
      title: 'Test',
      content: 'Testing Note',
      timestamp: DateTime.now(),
    );

    expect(const LoadNotesEvent() == const LoadNotesEvent(), true);

    expect(AddNotesEvent(note) == AddNotesEvent(note), true);

    expect(DeleteNotesEvent('1') == DeleteNotesEvent('1'), true);

    expect(AddNotesEvent(note) == UpdateNotesEvent(note), false);
  });

  test('NotesState Equatable test', () {
    final notes = [
      NoteEntity(
        id: '1',
        title: 'Test',
        content: 'Testing Note',
        timestamp: DateTime.now(),
      ),
    ];

    expect(const NotesInitialState() == const NotesInitialState(), true);

    expect(NotesLoadedState(notes) == NotesLoadedState(notes), true);

    expect(NotesErrorState('Error') == NotesErrorState('Error'), true);

    expect(const NotesLoadingState() == const NotesInitialState(), false);
  });
}
