import 'package:flutter/material.dart';
import 'package:personal_website/components/projectCard.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/models/project.dart';
import 'package:personal_website/responsive.dart';

class ProjectsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        title: Text(
          'Projects'
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveHelper().columns(context, 1, 1, 2, 3, 5),
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            childAspectRatio: 3 / 4
          ), 
          itemCount: projects.length,
          itemBuilder: (_, index) => ProjectCard(project: projects[index])
        ),
      )
    );
  }
}