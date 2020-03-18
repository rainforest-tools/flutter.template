import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/pages/empty.dart';
import 'package:personal_website/routes/route_handlers.dart';

void configureRoutes(Router router, List<RouteModel> routeHandlers) {
  router.notFoundHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      print('Page Not Found!');
      return EmptyPage();
    }
  );
  routeHandlers.forEach((routeHandler) {
    router.define(routeHandler.path, handler: routeHandler.handler);
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