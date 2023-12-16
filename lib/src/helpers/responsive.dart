import 'package:flutter/material.dart';

const responsiveMaxDialogWidth = 300.0;
const responsiveMaxDialogExtendedWidth = 400.0;
const responsiveMaxMainWidth = 600.0;

bool isBigScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 730;
}
