import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:note_pad/features/notes/domain/usecases/create_note_usecase.dart';
import 'package:note_pad/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:note_pad/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:note_pad/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';

part 'notes_state.dart';
part 'notes_event.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUsecase getNotesUsecase;
  final CreateNoteUsecase createNoteUsecase;
  final UpdateNoteUsecase updateNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;

  StreamSubscription? _notesSubcription;

  NotesBloc({
    required this.createNoteUsecase,
    required this.getNotesUsecase,
    required this.updateNoteUsecase,
    required this.deleteNoteUsecase,
  }) : super(NotesInitialState()) {
    on<LoadNotesEvent>(_onLoadEvent);
    on<StreamNotesEvent>(_onStreamEvent);
    on<AddNotesEvent>(_onAddEvent);
    on<UpdateNotesEvent>(_onUpdateEvent);
    on<DeleteNotesEvent>(_onDeleteEvent);
    on<ErrorNotesEvent>(_onErrorEvent);
  }

  //LoadNotesEvent handler
  Future<void> _onLoadEvent(
    LoadNotesEvent even,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoadingState());

    await _notesSubcription?.cancel();

    _notesSubcription = getNotesUsecase().listen(
      (notes) => add(StreamNotesEvent(notes)),
    );
  }

  //StreamNotesEvent handler
  void _onStreamEvent(StreamNotesEvent event, Emitter<NotesState> emit) {
    emit(NotesLoadedState(event.note));
  }

  //AddNotesEvent handler
  Future<void> _onAddEvent(
    AddNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await createNoteUsecase(event.note);
    } catch (e) {
      add(ErrorNotesEvent('Gagal menambah catatan: ${e.toString()}'));
    }
  }

  //UpdateNotesEvent handler
  Future<void> _onUpdateEvent(
    UpdateNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await updateNoteUsecase(event.note);
    } catch (e) {
      add(ErrorNotesEvent('Gagal mengupdate catatan: ${e.toString()}'));
    }
  }

  //DeleteNotesEvent handler
  Future<void> _onDeleteEvent(
    DeleteNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await deleteNoteUsecase(event.id);
    } catch (e) {
      add(ErrorNotesEvent('Gagal menghapus catatan: ${e.toString()}'));
    }
  }

  //ErrorNotesEvent handler
  void _onErrorEvent(ErrorNotesEvent event, Emitter<NotesState> emit) {
    emit(NotesErrorState(event.message));
  }

  @override
  Future<void> close() {
    _notesSubcription?.cancel();
    return super.close();
  }
}
