import 'package:flutter/material.dart';
import 'package:personal_website/models/project.dart';
import 'package:personal_website/models/settings.dart';
import 'package:personal_website/routes/routes.dart';
import 'package:provider/provider.dart';
import 'themes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkTheme),
        ),
        ChangeNotifierProvider<Routes>(create: (_) {
          final routesNotifier = Routes();
          routesNotifier.configure();
          return routesNotifier;
        }),
        ChangeNotifierProvider<SettingsNotifier>(create: (_) => SettingsNotifier()),
        ChangeNotifierProvider<TagsNotifier>(create: (_) => TagsNotifier(),)
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final routesNotifier = Provider.of<Routes>(context);
    return MaterialApp(
      title: 'Rainforest',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      onGenerateRoute: (routeSettings) => routesNotifier.router.generator(context, routeSettings),
    );
  }
}