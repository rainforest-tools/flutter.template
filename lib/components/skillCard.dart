import 'package:flutter/material.dart';
import 'package:personal_website/models/skill.dart';

class SkillCard extends StatelessWidget {
  const SkillCard({
    Key key,
    this.skill
  }) : super(key: key);

  final Skill skill;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(
        skill.icon,
        size: 50,
      ),
      RichText(
        text: TextSpan(
          text: skill.skillName,
          style: DefaultTextStyle.of(context).style.apply(
            fontSizeFactor: 2.0,
            color: Colors.tealAccent
          ),
          children: <TextSpan>[
            TextSpan(
              text: '''\n${skill.description}''',
              style: DefaultTextStyle.of(context).style.apply(
                color: Colors.white70
              )
            )
          ]
        )
      )
    ],
  );
}