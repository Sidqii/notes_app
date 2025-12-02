import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titlePage;

  const CustomAppbar({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: -10,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey.shade900,
            size: 20,
          ),
        ),
      ),
      title: Text(
        titlePage,
        style: TextStyle(
          color: Colors.grey.shade900,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
