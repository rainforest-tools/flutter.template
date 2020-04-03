import 'package:flutter/material.dart';
import 'package:personal_website/models/settings.dart';
import 'package:personal_website/themes.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({
    Key key,
    this.backArrowAction
  }) : super(key: key);

  final void Function() backArrowAction;

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: widget.backArrowAction
        ),
        title: const Text('Setting')
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: settingsNotifier.settings.isDarkMode, 
                onChanged: (bool value) {
                  settingsNotifier.setSettings(SettingsEnum.isDarkMode, value);
                  settingsNotifier.settings.isDarkMode ? themeNotifier.setTheme(darkTheme) : themeNotifier.setTheme(lightTheme);
                }
              ),
              DropdownButtonFormField(
                value: settingsNotifier.settings.layout,
                decoration: InputDecoration(
                  labelText: 'Layout'
                ),
                items: Layout.values.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString().split('.').last.toLowerCase())
                )).toList(), 
                onChanged: (value) {
                  print(value);
                  settingsNotifier.setSettings(SettingsEnum.layout, value);
                }
              )
            ]
          ),
        ),
      ),
    );
  }
}