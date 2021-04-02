import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/pages/empty.dart';
import 'package:personal_website/routes/route_handlers.dart';

void configureRoutes(FluroRouter router, List<RouteModel> routeHandlers) {
  routeHandlers.forEach((routeHandler) {
    router.define(routeHandler.path + routeHandler.queryRule,
        handler: routeHandler.handler, transitionType: TransitionType.fadeIn);
    if (routeHandler.routes != null)
      configureRoutes(router, routeHandler.routes);
  });
}

class Routes extends ChangeNotifier {
  final _router = FluroRouter();

  FluroRouter get router => _router;

  void configure() {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return EmptyPage();
    });
    configureRoutes(_router, route_handlers);

    notifyListeners();
  }
}
