import 'package:flutter/material.dart';
import 'package:personal_website/components/settingsForm.dart';
import 'package:personal_website/layouts/default.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        title: Text('Rainforest'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsForm()))
          ),
        ],
      ),
      body: Center(child: Text('Home Page'),)
    );
  }
}