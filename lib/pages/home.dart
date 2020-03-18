import 'package:flutter/material.dart';
import 'package:personal_website/components/myAppBar.dart';
import 'package:personal_website/components/settingsForm.dart';
import 'package:personal_website/layouts/default.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: MyAppBar(
        title: Text('Rainforest'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsForm()))
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.amber,
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("鄭羽霖"),
                  Text("Frontend Developer")
                ]
              )
            ),
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("鄭羽霖"),
                  Text("Frontend Developer")
                ]
              )
            )
          ],
        )
      )
    );
  }
}