import 'package:flutter/material.dart';

class ContentCreateNote extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  const ContentCreateNote({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
          minLines: 1,
          maxLines: null,
        ),

        const SizedBox(height: 15),

        TextField(
          controller: contentController,
          decoration: InputDecoration(
            labelText: 'Description',
            alignLabelWithHint: true,
            border: OutlineInputBorder(),
          ),
          minLines: 5,
          maxLines: null,
        ),
      ],
    );
  }
}
