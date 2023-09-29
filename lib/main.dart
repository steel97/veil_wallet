import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/mobile/main_layout.dart';
import 'package:veil_wallet/src/views/home.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/import_seed_advanced.dart';
import 'package:veil_wallet/src/views/new_wallet_save_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_verify_seed.dart';
import 'package:veil_wallet/src/views/settings.dart';
import 'package:veil_wallet/src/views/setup_biometrics.dart';
import 'package:veil_wallet/src/views/welcome.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var lightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: const Color.fromARGB(255, 35, 89, 247),
      surface: const Color.fromARGB(255, 233, 239, 247),
      //Color.fromARGB(233, 247, 247, 247), // color of cards, dropdowns etc
      //
      //secondaryContainer: const Color.fromARGB(255, 249, 249, 249),
      //onSecondaryContainer: const Color.fromARGB(255, 35, 89, 247),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
