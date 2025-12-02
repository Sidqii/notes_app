import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/presentation/bloc/crud/notes_bloc.dart';
import 'package:note_pad/features/notes/presentation/utils/notes_success_dialog.dart';
import 'package:uuid/uuid.dart';

class BtnCreateNote extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  static bool _onButton = false;

  const BtnCreateNote({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final title = titleController.text.trim();

        final content = contentController.text.trim();

        final messenger = ScaffoldMessenger.of(context);

        if (_onButton) return;

        if (title.isEmpty) {
          _onButton = true;

          Future.delayed(const Duration(seconds: 1), () {
            _onButton = false;
          });

          messenger.showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Title is required'),
            ),
          );

          return;
        }

        FocusScope.of(context).unfocus();

        final uuid = const Uuid().v4();

        final note = NoteEntity(
          id: uuid,
          title: title,
          content: content,
          timestamp: DateTime.now(),
        );

        context.read<NotesBloc>().add(AddNotesEvent(note));

        await showSuccessDialog(context);

        if (!context.mounted) return;

        Navigator.pop(context);
      },
      child: const Text('Create'),
    );
  }
}
