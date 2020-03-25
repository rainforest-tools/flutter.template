import 'package:flutter/material.dart';
import 'package:personal_website/components/settingsForm.dart';
import 'package:personal_website/layouts/default.dart';
import 'package:personal_website/routes/routes.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final routesNotifier = Provider.of<Routes>(context);
    return DefaultLayout(
      appBar: AppBar(
        title: Text('Projects'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsForm()))
          ),
          IconButton(
            icon: const Icon(Icons.settings_input_composite),
            tooltip: 'kdcjks',
            onPressed: () {
              routesNotifier.router.navigateTo(context, 'jflsjlgjldk');
            }
          ),
        ],
      ),
      body: Center(child: Text(
        'Comming soooon...', 
        style: DefaultTextStyle.of(context).style.apply(
          fontSizeFactor: 2,
          color: Colors.tealAccent,
          decoration: TextDecoration.none
        )
      ),)
    );
  }
}