import 'package:flutter/material.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/presentation/widgets/btn_update_note.dart';
import 'package:note_pad/features/notes/presentation/widgets/custom_appbar.dart';
import 'package:note_pad/features/notes/presentation/widgets/content_edit_note.dart';

class PageEditNote extends StatefulWidget {
  final NoteEntity note;

  const PageEditNote({super.key, required this.note});

  @override
  State<PageEditNote> createState() => _PageEditNoteState();
}

class _PageEditNoteState extends State<PageEditNote> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(titlePage: 'Edit note'),

      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ContentEditNote(
                    date: widget.note.timestamp,
                    titleController: titleController,
                    contentController: contentController,
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: BtnUpdateNote(
                  note: widget.note,
                  titleController: titleController,
                  contentController: contentController,
                ),
              ),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
