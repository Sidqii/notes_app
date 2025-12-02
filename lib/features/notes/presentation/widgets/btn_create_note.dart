import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/presentation/bloc/crud/notes_bloc.dart';
import 'package:uuid/uuid.dart';

class BtnCreateNote extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  const BtnCreateNote({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final title = titleController.text.trim();
        final content = contentController.text.trim();

        if (title.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Title is required')));

          return;
        }

        final uuid = const Uuid().v4();

        final note = NoteEntity(
          id: uuid,
          title: title,
          content: content,
          timestamp: DateTime.now(),
        );

        context.read<NotesBloc>().add(AddNotesEvent(note));

        Navigator.pop(context);
      },
      child: const Text('Save'),
    );
  }
}
