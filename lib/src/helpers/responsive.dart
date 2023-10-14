import 'package:flutter/material.dart';

bool isBigScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 730;
}
