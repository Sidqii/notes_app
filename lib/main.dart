import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/core/theme/app_theme_pallete.dart';

import 'package:note_pad/injection/injection.dart';
import 'package:note_pad/features/notes/presentation/bloc/crud/notes_bloc.dart';
import 'package:note_pad/features/notes/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    BlocProvider(
      create: (_) => sl<NotesBloc>()..add(LoadNotesEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemePallete.frostTheme,
      home: HomePage(),
    );
  }
}
