import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_website/util.dart';

class SocialBar extends StatefulWidget {
  SocialBar(
      {Key? key,
      this.direction = Axis.horizontal,
      this.isCollapsable = false,
      this.isCollapsed = false,
      this.iconSize})
      : super(key: key);

  final Axis direction;
  final bool isCollapsable;
  final bool isCollapsed;
  final double? iconSize;

  @override
  _SocialBarState createState() => _SocialBarState();
}

class _SocialBarState extends State<SocialBar> {
  bool? _isCollapsed;
  bool? _isReversed;
  bool? _isMiddle;
  Widget? _floatingButton;
  List<Widget> _buttons = [];

  @override
  void initState() {
    WidgetsBinding.instance
      ?..addPostFrameCallback((_) => _handlePositionUpdate());
    super.initState();
    _isCollapsed = widget.isCollapsed;
    _isReversed = false;
    _isMiddle = false;
  }

  Widget animatedContainer(Widget child, bool value) => AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        opacity: value ? 0 : 1,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
          width: value ? 0 : 56,
          height: value ? 0 : 56,
          child: Transform.rotate(
              angle: _isCollapsed! ? math.pi * 2 : 0, child: child),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _floatingButton = AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: Transform.rotate(
        angle: _isCollapsed! ? math.pi * 2 : 0,
        child: InkWell(
            splashColor: Theme.of(context).primaryColor,
            child: SizedBox(
                width: 56,
                height: 56,
                child: Icon(_isCollapsed! ? Icons.message : Icons.cancel)),
            onTap: () => setState(() {
                  _isCollapsed = !_isCollapsed!;
                })),
      ),
    );
    _buttons = <Widget>[
      Flexible(
        child: animatedContainer(
            IconButton(
                tooltip: 'E-Mail',
                icon: Icon(
                  Icons.mail_outline,
                  size: widget.iconSize,
                ),
                onPressed: () =>
                    launchURL(context, 'mailto:rainforestnick@gmail.com')),
            _isCollapsed!),
      ),
      Flexible(
        child: animatedContainer(
            IconButton(
                tooltip: 'LinkedIn',
                icon: Icon(FontAwesomeIcons.linkedin, size: widget.iconSize),
                onPressed: () => launchURL(context,
                    'https://www.linkedin.com/in/yulin-cheng-530b2911b/')),
            _isCollapsed!),
      ),
      Flexible(
        child: animatedContainer(
            IconButton(
                tooltip: 'Medium',
                icon: Icon(FontAwesomeIcons.medium, size: widget.iconSize),
                onPressed: () =>
                    launchURL(context, 'https://medium.com/@rainforestnick')),
            _isCollapsed!),
      ),
      Flexible(
        child: animatedContainer(
          IconButton(
              tooltip: 'Instagram',
              icon: Icon(FontAwesomeIcons.instagram, size: widget.iconSize),
              onPressed: () => launchURL(
                  context, 'https://www.instagram.com/rainforest__film/')),
          _isCollapsed!,
        ),
      ),
    ];

    return Material(
      borderRadius: BorderRadius.circular(28),
      color: widget.isCollapsable
          ? Theme.of(context).accentColor
          : Colors.transparent,
      child: widget.direction == Axis.horizontal
          ? Row(mainAxisSize: MainAxisSize.min, children: _getChildren())
          : Column(children: _getChildren()),
    );
  }

  List<Widget> _getChildren() {
    if (!widget.isCollapsable) return _buttons;
    if (_isMiddle!) {
      _buttons.insert(
          _buttons.length.isOdd
              ? (_buttons.length / 2).floor()
              : (_buttons.length / 2).floor(),
          _floatingButton!);
      return _buttons;
    }
    _buttons.insert(0, _floatingButton!);
    return _isReversed! ? _buttons.reversed.toList() : _buttons;
  }

  void _handlePositionUpdate() {
    try {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      final globalSize = MediaQuery.of(context).size;
      if (widget.direction == Axis.horizontal) {
        if (offset.dx > globalSize.width / 2 + globalSize.width * 0.1)
          setState(() {
            _isReversed = true;
            _isMiddle = false;
          });
        else if (offset.dx < globalSize.width / 2 - globalSize.width * 0.1)
          setState(() {
            _isReversed = false;
            _isMiddle = false;
          });
        else
          setState(() {
            _isMiddle = true;
          });
      } else {
        if (offset.dy > globalSize.height / 2)
          setState(() {
            _isReversed = true;
          });
      }
    } catch (error) {
      print(error);
    }
  }
}
