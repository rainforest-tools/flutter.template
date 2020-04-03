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
          Tooltip(
            message: 'E-Mail',
            child: IconButton(
              icon: Icon(Icons.mail_outline, size: iconSize,), 
              onPressed: () => launchURL('mailto:rainforestnick@gmail.com')
            ),
          ),
          Tooltip(
            message: 'LinkedIn',
            child: IconButton(
              icon: Icon(FontAwesomeIcons.linkedin, size: iconSize), 
              onPressed: () => launchURL('https://www.linkedin.com/in/yulin-cheng-530b2911b/')
            ),
          ),
          Tooltip(
            message: 'Medium',
            child: IconButton(
              icon: Icon(FontAwesomeIcons.medium, size: iconSize), 
              onPressed: () => launchURL('https://medium.com/@rainforestnick')
            ),
          ),
          Tooltip(
            message: 'Instagram',
            child: IconButton(
              icon: Icon(FontAwesomeIcons.instagram, size: iconSize), 
              onPressed: () => launchURL('https://www.instagram.com/rainforest__film/')
            ),
          ),
        ],
      ),
    );
  }
}