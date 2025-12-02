import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:note_pad/features/notes/presentation/utils/notes_color_pallete.dart';

Color notesColorGenerator(String id){
  final seed = id.hashCode & 0x7fffffff;

  final random = Random(seed);

  final index = random.nextInt(notesColorPalllete.length);

  return notesColorPalllete[index];
}