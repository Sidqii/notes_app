import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/presentation/bloc/crud/notes_bloc.dart';
import 'package:note_pad/features/notes/presentation/utils/notes_success_dialog.dart';

class BtnUpdateNote extends StatelessWidget {
  final NoteEntity note;
  final TextEditingController titleController;
  final TextEditingController contentController;

  const BtnUpdateNote({
    super.key,
    required this.note,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final newTitle = titleController.text.trim();
        final newContent = contentController.text.trim();

        bool sameInput = false;

        if (newTitle.isEmpty || newContent.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cant save empty notes')),
          );

          return;
        }

        final oldTitle = note.title;
        final oldContent = note.content;

        if (newTitle != oldTitle) sameInput = true;

        if (newContent != oldContent) sameInput = true;

        if (!sameInput) return;

        FocusScope.of(context).unfocus();

        final updateNote = NoteEntity(
          id: note.id,
          title: newTitle,
          content: newContent,
          timestamp: DateTime.now(),
        );

        context.read<NotesBloc>().add(UpdateNotesEvent(updateNote));

        await showSuccessDialog(context);

        if (!context.mounted) return;

        Navigator.pop(context);
      },
      child: const Text('Update'),
    );
  }
}
