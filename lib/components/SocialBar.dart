import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_website/util.dart';

class SocialBar extends StatelessWidget {
  const SocialBar({Key key, this.iconSize}) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: 'E-Mail',
            icon: Icon(Icons.mail_outline, size: iconSize,), 
            onPressed: () => launchURL(context, 'mailto:rainforestnick@gmail.com')
          ),
          IconButton(
            tooltip: 'LinkedIn',
            icon: Icon(FontAwesomeIcons.linkedin, size: iconSize), 
            onPressed: () => launchURL(context, 'https://www.linkedin.com/in/yulin-cheng-530b2911b/')
          ),
          IconButton(
            tooltip: 'Medium',
            icon: Icon(FontAwesomeIcons.medium, size: iconSize), 
            onPressed: () => launchURL(context, 'https://medium.com/@rainforestnick')
          ),
          IconButton(
            tooltip: 'Instagram',
            icon: Icon(FontAwesomeIcons.instagram, size: iconSize), 
            onPressed: () => launchURL(context, 'https://www.instagram.com/rainforest__film/')
          ),
        ],
      ),
    );
  }
}