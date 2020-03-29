import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:personal_website/models/project.dart';
import 'package:personal_website/util.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key key,
    this.project
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Text(
            project.name,
            style: DefaultTextStyle.of(context).style.apply(
              fontSizeFactor: 2,
              color: Colors.tealAccent
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              project.description,
              style: DefaultTextStyle.of(context).style.apply(
                color: Colors.white70
              ),
            ),
          ),
          Spacer(),
          Tooltip(
            message: project.url != null ? project.url : 'Private Project',
            child: FlatButton.icon(
              label: Text('前往專案'),
              icon: Icon(_getIcon()),
              
              onPressed: project.url != null ? () => launchURL(project.url) : null
            ),
          ),
        ]
      ),
    )
  );

  IconData _getIcon() {
    if (project is CodepenProject) return BrandIcons.codepen;
    return Icons.code;
  }
}