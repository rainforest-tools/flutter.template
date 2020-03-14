import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/routes/route_handlers.dart';

void configureRoutes(Router router, List<RouteModel> routeHandlers) {
  routeHandlers.forEach((routeHandler) {
    if (routeHandler.path == '/404') {
      router.notFoundHandler = routeHandler.handler;
    } else {
      router.define(routeHandler.path, handler: routeHandler.handler);
    }
  });
}

class Routes extends ChangeNotifier {
  final Router _router = Router();

  Router get router => _router;

  void configure() {
    configureRoutes(_router, route_handlers);

    notifyListeners();
  }
}