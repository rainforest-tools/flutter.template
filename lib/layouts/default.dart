import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/components/settingsForm.dart';
import 'package:personal_website/routes/route_handlers.dart';
import 'package:personal_website/routes/routes.dart';
import 'package:provider/provider.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    Key key, this.appBar, this.body
  }) : super(key: key);

  final Widget appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final routesNotifier = Provider.of<Routes>(context);
    final controller = PageController(
      initialPage: 0
    );
    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: PageView(
            controller: controller,
            children: <Widget>[
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: route_handlers.length,
                      itemBuilder: (_, int index) {
                        if (route_handlers[index].showOnDrawer)
                          return ListTile(
                            title: new Text(
                              route_handlers[index].title,
                              style: Theme.of(context).textTheme.subtitle1.apply(
                                color: Theme.of(context).textTheme.subtitle1.color.withAlpha(255)
                              ),
                            ),
                            onTap: () {
                              Navigator.popUntil(context, (route) {
                                if (route.settings.name != route_handlers[index].path) {
                                  // Navigator.pushNamed(context, route_handlers[index].path);
                                  if (route_handlers[index].transitionType == TransitionType.custom) {
                                    routesNotifier.router.navigateTo(
                                      context, 
                                      route_handlers[index].path,
                                      transition: TransitionType.custom,
                                      transitionDuration: Duration(milliseconds: 800),
                                      transitionBuilder: route_handlers[index].transitionBuilder
                                    );
                                  } else {
                                    routesNotifier.router.navigateTo(
                                      context, 
                                      route_handlers[index].path,
                                    );
                                  };
                                }
                                return true;
                              });
                            }
                          );
                      }
                    )
                  ),
                  Spacer(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                    onTap: () => controller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.bounceInOut),
                  )
                ],
              ),
              SettingsForm(
                backArrowAction: () => controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.bounceInOut),
              )
            ]
          ),
        )
      ),
      body: body,
    );
  }
}