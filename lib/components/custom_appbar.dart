import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double height; // Added height parameter

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.height = 48.0, // Default to 48.0 (smaller than standard 56.0)
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Constrain the height
      child: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18, // Slightly smaller font
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        actions: actions,
        leading: leading,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: height, // Set toolbar height
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height); // Use custom height
}
