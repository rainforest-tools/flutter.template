import 'package:flutter/material.dart';
import 'package:personal_website/routes/route_handlers.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    Key key, this.appBar, this.body
  }) : super(key: key);

  final Widget appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: route_handlers.length,
                itemBuilder: (_, int index) {
                  return ListTile(
                    title: new Text(route_handlers[index].title),
                    onTap: () {
                      Navigator.popUntil(context, (route) {
                        if ( route.settings.name != route_handlers[index].path) {
                          Navigator.pushNamed(context, route_handlers[index].path);
                        }
                        return true;
                      });
                    }
                  );
                }
              )
            )
          ]
        )
      ),
      body: body,
    );
  }
}