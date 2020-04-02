import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_website/util.dart';

class SocialBar extends StatelessWidget {
  const SocialBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Tooltip(
          message: 'E-Mail',
          child: IconButton(
            icon: Icon(Icons.mail_outline), 
            onPressed: () => launchURL('mailto:rainforestnick@gmail.com')
          ),
        ),
        Tooltip(
          message: 'LinkedIn',
          child: IconButton(
            icon: Icon(FontAwesomeIcons.linkedin), 
            onPressed: () => launchURL('https://www.linkedin.com/in/yulin-cheng-530b2911b/')
          ),
        ),
        Tooltip(
          message: 'Medium',
          child: IconButton(
            icon: Icon(FontAwesomeIcons.medium), 
            onPressed: () => launchURL('https://medium.com/@rainforestnick')
          ),
        ),
        Tooltip(
          message: 'Instagram',
          child: IconButton(
            icon: Icon(FontAwesomeIcons.instagram), 
            onPressed: () => launchURL('https://www.instagram.com/rainforest__film/')
          ),
        ),
      ],
    );
  }
}