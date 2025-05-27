import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double height;
  final Color titleColor;
  final double elevation;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.height = kToolbarHeight, // Use Flutter's standard toolbar height
    this.titleColor = Colors.white,
    this.elevation = 1.0,
    this.borderRadius,
    this.titleStyle,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style:
            titleStyle ??
            TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: titleColor,
              letterSpacing: 0.5,
            ),
      ),
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ??
            BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
      ),
      toolbarHeight: height,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius:
              borderRadius ??
              BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
          gradient:
              backgroundColor == Colors.blue
                  ? LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
        ),
      ),
      iconTheme: IconThemeData(
        color: titleColor, // Match icon color with title color
      ),
      actionsIconTheme: IconThemeData(
        color: titleColor, // Match action icons color with title color
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
