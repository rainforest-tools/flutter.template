import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    copy(context, url).then((value) async => await launch(url));
  } else {
    // TODO: replace deprecated members here
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Oops! Link couldn't be luanched!"),
    ));
    copy(context, url);
  }
}

Future<void> copy(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text)).then(
    // TODO: replace deprecated members here
    (value) => Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Copied'),
    )),
    // TODO: replace deprecated members here
    onError: (error) => Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Oops! Something went wrong!'),
    )),
  );
}

T? enumFromString<T>(Iterable<T> values, String value) {
  try {
    return value != null
        ? values.firstWhere(
            (type) =>
                type.toString().split('.').last.toLowerCase() ==
                value.toLowerCase(),
          )
        : null;
  } on StateError {
    return null;
  }
}

String getIdFromUniqueKey(UniqueKey key) =>
    key.toString().replaceAll(new RegExp(r'[\[\]\#]'), '');
