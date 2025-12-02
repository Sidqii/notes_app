import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_pad/features/notes/domain/entities/note_entity.dart';
import 'package:note_pad/features/notes/presentation/bloc/crud/notes_bloc.dart';
import 'package:note_pad/features/notes/presentation/utils/notes_color_generator.dart';
import 'package:note_pad/features/notes/presentation/utils/notes_date_formatter.dart';

class CardNoteTiles extends StatefulWidget {
  final NoteEntity note;
  final VoidCallback onTap;

  const CardNoteTiles({required this.note, required this.onTap, super.key});

  @override
  State<CardNoteTiles> createState() => _CardNoteTilesState();
}

class _CardNoteTilesState extends State<CardNoteTiles> {
  bool fadeOut = false;
  bool popupShow = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.note.id),

      direction: DismissDirection.endToStart,

      confirmDismiss: (direction) async => false,

      dragStartBehavior: DragStartBehavior.down,

      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 35),
        child: const Icon(Icons.delete, color: Colors.white, size: 35),
      ),

      onUpdate: (details) async {
        if (details.progress > 0.8 && !popupShow) {
          popupShow = true;

          final result = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Text(
                      '⚠️ ',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Delete note:',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                content: Text(widget.note.title),

                actions: [
                  TextButton(
                    onPressed: () {
                      popupShow = false;

                      Navigator.pop(context, false);
                    },
                    child: const Text('Cancel'),
                  ),

                  TextButton(
                    onPressed: () async {
                      popupShow = true;

                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );

          if (result == true) {
            setState(() {
              fadeOut = true;
            });

            await Future.delayed(Duration(milliseconds: 350));

            if (!context.mounted) return;

            context.read<NotesBloc>().add(DeleteNotesEvent(widget.note.id));

            popupShow = false;
          }
        }
      },

      dismissThresholds: const {DismissDirection.endToStart: 0.5},

      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 350),
        opacity: fadeOut ? 0.0 : 1.0,

        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: notesColorGenerator(widget.note.id),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey.shade900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                Text(
                  widget.note.content,
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 2,
                  ),
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      notesDateFormatter(widget.note.timestamp),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
