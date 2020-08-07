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
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      Hero(
        tag: 'projectCard ${getIdFromUniqueKey(project.id)}',
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: project.imageUrl != null ? Image(
            image: AssetImage(project.imageUrl),
            fit: BoxFit.cover,
          ) : Card(
            color: Theme.of(context).accentColor,
            child: Center(child: Icon(Icons.image))
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: Transform.translate(
          offset: Offset(0, -30),
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  bottomNavigationBar: ProjectCardActions(project: project, mainAxisAlignment: MainAxisAlignment.spaceAround,),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          project.name,
                          style: Theme.of(context).textTheme.headline6.apply(
                            color: Theme.of(context).primaryColor
                          )
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                      ),
                    ]
                  ),
                ),
              )
            ),
          ),
        ),
      ),
    ],
  );
}

class ProjectCardActions extends StatelessWidget {
  const ProjectCardActions({
    Key key, 
    @required this.project,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.isLabelShowed = true
  }) : super(key: key);

  final Project project;
  final MainAxisAlignment mainAxisAlignment;
  final bool isLabelShowed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          Tooltip(
            message: project.url != null ? project.url : 'Private Project',
            child: isLabelShowed ? FlatButton.icon(
              label: Text('前往專案'),
              icon: Icon(_getIcon()),
              onPressed: project.url != null ? () => launchURL(context, project.url) : null
            ) : IconButton(
              padding: EdgeInsets.all(0),
              alignment: Alignment.centerLeft,
              icon: Icon(_getIcon()),
              onPressed: project.url != null ? () => launchURL(context, project.url) : null
            ),
          ),
          if (project is FrontendProject) () {
            final frontendProject = project as FrontendProject;
            final deployUrl = frontendProject.deployUrl;
            if (deployUrl != null) return isLabelShowed ? FlatButton.icon(
              icon: Icon(Icons.web), 
              label: isLabelShowed ? Text('Demo') : Text(''),
              onPressed: deployUrl != null ? () => launchURL(context, deployUrl) : null
            ) : IconButton(
              padding: EdgeInsets.all(0),
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.web), 
              onPressed: deployUrl != null ? () => launchURL(context, deployUrl) : null
            );
          }()
        ],
      ),
    );
  }

  IconData _getIcon() {
    if (project is CodepenProject) return BrandIcons.codepen;
    return Icons.code;
  }
}