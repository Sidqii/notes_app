import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:note_pad/features/notes/data/datasources/note_remote_datasource.dart';
import 'package:note_pad/features/notes/data/datasources/note_remote_datasource_impl.dart';
import 'package:note_pad/features/notes/data/repositories/note_repository_impl.dart';
import 'package:note_pad/features/notes/domain/repositories/note_repository.dart';
import 'package:note_pad/features/notes/domain/usecases/create_note_usecase.dart';
import 'package:note_pad/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:note_pad/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:note_pad/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:note_pad/features/notes/presentation/bloc/crud/notes_bloc.dart';
import 'package:note_pad/firebase_options.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  sl.registerLazySingleton<NoteRemoteDatasource>(
    () => NoteRemoteDatasourceImpl(),
  );

  sl.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(sl()));

  sl.registerLazySingleton(() => CreateNoteUsecase(sl()));

  sl.registerLazySingleton(() => GetNotesUsecase(sl()));

  sl.registerLazySingleton(() => UpdateNoteUsecase(sl()));

  sl.registerLazySingleton(() => DeleteNoteUsecase(sl()));

  sl.registerFactory(
    () => NotesBloc(
      createNoteUsecase: sl(),
      getNotesUsecase: sl(),
      updateNoteUsecase: sl(),
      deleteNoteUsecase: sl(),
    ),
  );

  timeago.setLocaleMessages('id', timeago.IdMessages());
}
