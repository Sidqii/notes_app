import 'package:flutter/material.dart';
import 'package:note_pad/features/notes/presentation/utils/notes_date_formatter.dart';

class ContentEditNote extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final DateTime date;

  const ContentEditNote({
    super.key,
    required this.date,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: titleController,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            isDense: true,
            border: InputBorder.none,
          ),
          minLines: 1,
          maxLines: null,
        ),

        const SizedBox(height: 30),

        Text(
          notesFormalFormatter(date),
          style: const TextStyle(fontSize: 12, color: Color(0xFF686D76)),
        ),

        const SizedBox(height: 5),

        const Divider(),

        TextField(
          controller: contentController,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            border: InputBorder.none,
          ),
          minLines: 5,
          maxLines: null,
        ),
      ],
    );
  }
}
