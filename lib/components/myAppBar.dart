import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key key,
    this.title,
    this.actions = const <Widget>[]
  }) : super(key: key);
  
  final Widget title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: title,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}