import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/pages/home.dart';
import 'package:personal_website/pages/projects.dart';

class RouteModel {
  RouteModel({
    Key key,
    this.title,
    this.path,
    this.handler
  });

  final String title;
  final String path;
  final Handler handler;
}

var route_handlers = [
  new RouteModel(
    title: 'Home',
    path: '/',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) => HomePage()
    ),
  ),
  new RouteModel(
    title: 'Projects',
    path: '/projects',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) => ProjectsPage()
    ),
  ),
];
