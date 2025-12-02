import 'dart:async';

import 'package:flutter/material.dart';

Future<void> showSuccessDialog(BuildContext context) async {
  final overlay = Overlay.of(context);

  late OverlayEntry entry;

  final completer = Completer<void>();

  entry = OverlayEntry(
    builder: (context) {
      return _NotesSuccessDialogue(
        onFinished: () {
          entry.remove();

          completer.complete();
        },
      );
    },
  );

  overlay.insert(entry);

  return completer.future;
}

class _NotesSuccessDialogue extends StatefulWidget {
  final VoidCallback onFinished;

  const _NotesSuccessDialogue({required this.onFinished});

  @override
  State<_NotesSuccessDialogue> createState() => _NotesSuccessDialogueState();
}

class _NotesSuccessDialogueState extends State<_NotesSuccessDialogue>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    opacity = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    scale = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onFinished();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: FadeTransition(
          opacity: opacity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 65,
            width: 65,
            child: const Icon(Icons.check_sharp, color: Colors.white, size: 45),
          ),
        ),
      ),
    );
  }
}
