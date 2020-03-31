import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/pages/home.dart';
import 'package:personal_website/pages/projects.dart';

class RouteModel {
  RouteModel({
    Key key,
    this.title,
    this.path,
    this.handler,
    this.transitionType = TransitionType.fadeIn,
    this.transitionBuilder
  });

  final String title;
  final String path;
  final Handler handler;
  final TransitionType transitionType;
  final Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transitionBuilder;
}

var route_handlers = [
  new RouteModel(
    title: 'Home',
    path: '/',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) => HomePage()
    ),
    transitionType: TransitionType.custom,
    transitionBuilder: transitionBuilder
  ),
  new RouteModel(
    title: 'Projects',
    path: '/projects',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, List<Object>> params) => ProjectsPage()
    ),
    transitionType: TransitionType.custom,
    transitionBuilder: transitionBuilder
  ),
];

Widget transitionBuilder (context, animation, secondaryAnimation, child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: Offset(0.3, 0),
      end: Offset.zero
    ).chain(CurveTween(
      curve: Interval(0.5, 1, curve: Curves.easeInOut)
    )).animate(animation),
    child: FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1
      ).chain(CurveTween(
        curve: Interval(0.5, 0.8, curve: Curves.easeInOut)
      )).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(0.5, 0)
        ).chain(CurveTween(
          curve: Interval(0, 0.8, curve: Curves.easeInOut)
        )).animate(secondaryAnimation),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 1,
            end: 0
          ).chain(CurveTween(
            curve: Interval(0, 0.8, curve: Curves.easeInOut)
          )).animate(secondaryAnimation),
          child: child
        ),
      ),
    ),
  );
}
