import 'package:flutter/material.dart';
import 'package:note_pad/core/const/color_pallete.dart';

class AppThemePallete {
  static final ThemeData frostTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      primary: ColorPallete.frost,
      onPrimary: Color(0xFFF7F7F7),

      secondary: ColorPallete.frost,
      onSecondary: Color(0xFFF7F7F7),

      surface: Color(0xFFF7F7F7),
      onSurface: ColorPallete.textDark,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFF7F7F7),
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
    ),
  );
}
