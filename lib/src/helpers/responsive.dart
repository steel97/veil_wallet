import 'package:flutter/material.dart';

const responsiveMaxDialogWidth = 300.0;

bool isBigScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 730;
}
