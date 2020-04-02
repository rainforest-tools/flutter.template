import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // throw 'Could not launch $url';
  }
}

T enumFromString<T>(Iterable<T> values, String value) {
  return value != null ? values.firstWhere(
    (type) => type.toString().split('.').last.toLowerCase() == value.toLowerCase(),
    orElse: () => null
  ) : null;
}

String getIdFromUniqueKey(UniqueKey key) => key.toString().replaceAll(new RegExp(r'[\[\]\#]'), '');
