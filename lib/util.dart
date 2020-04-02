import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    await Clipboard.setData(ClipboardData(text: url));
  }
}

T enumFromString<T>(Iterable<T> values, String value) {
  return value != null ? values.firstWhere(
    (type) => type.toString().split('.').last.toLowerCase() == value.toLowerCase(),
    orElse: () => null
  ) : null;
}

String getIdFromUniqueKey(UniqueKey key) => key.toString().replaceAll(new RegExp(r'[\[\]\#]'), '');
