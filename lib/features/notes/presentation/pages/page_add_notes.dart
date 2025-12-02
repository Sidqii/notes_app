import 'package:flutter/material.dart';
import 'package:note_pad/features/notes/presentation/widgets/custom_appbar.dart';
import 'package:note_pad/features/notes/presentation/widgets/content_create_note.dart';
import 'package:note_pad/features/notes/presentation/widgets/btn_create_note.dart';

class PageAddNotes extends StatefulWidget {
  const PageAddNotes({super.key});

  @override
  State<PageAddNotes> createState() => _PageAddNotesState();
}

class _PageAddNotesState extends State<PageAddNotes> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(titlePage: 'Create note'),

      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),

        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  ContentCreateNote(
                    titleController: titleController,
                    contentController: contentController,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: BtnCreateNote(
                  titleController: titleController,
                  contentController: contentController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
