import 'package:flutter/material.dart';

class ResponsiveHelper {

  ResponsiveHelper();

  bool isXsmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
  bool isSmall(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
    MediaQuery.of(context).size.width < 1024;
  }
  bool isMedium(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024 &&
    MediaQuery.of(context).size.width < 1440;
  }
  bool isLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1440 &&
    MediaQuery.of(context).size.width < 1920;
  }
  bool isXlarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1920;
  }
  int columns(BuildContext context, int xs, int sm, int md, int lg, int xl) {
    if (isXsmall(context)) return xs;
    if (isSmall(context)) return sm;
    if (isMedium(context)) return md;
    if (isLarge(context)) return lg;
    if (isXlarge(context)) return xl;
  }
  int gutters(BuildContext context, int xs, int sm, int md, int lg, int xl) {
    if (isXsmall(context)) return xs;
    if (isSmall(context)) return sm;
    if (isMedium(context)) return md;
    if (isLarge(context)) return lg;
    if (isXlarge(context)) return xl;
  }
}