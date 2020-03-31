import 'package:flutter/material.dart';
import 'package:personal_website/components/bulletList.dart';
import 'package:personal_website/models/skill.dart';

class SkillCard extends StatelessWidget {
  const SkillCard({
    Key key,
    this.skill
  }) : super(key: key);

  final Skill skill;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            skill.icon,
            size: 50,
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                skill.name, 
                style: Theme.of(context).textTheme.headline6.apply(
                  color: Theme.of(context).primaryColor
                )
              ),
            ),
            subtitle: _getDescriptionWidget(context, skill.description),
          ),
        ],
      ),
    ),
  );

  Widget _getDescriptionWidget (BuildContext context, List<String> description) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    switch (description.length) {
      case 0:
        return Text('');
      case 1:
        return Text(
          description.first,
          style: textStyle
        );
      default:
        return BulletList(
          texts: description,
          textStyle: textStyle,
        );
    }
  }
}