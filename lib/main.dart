import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_wallet/src/layouts/main_layout.dart';
import 'package:veil_wallet/src/views/import_seed.dart';
import 'package:veil_wallet/src/views/new_wallet_verify_seed.dart';
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
        primary: const Color.fromARGB(255, 35, 89, 247));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      home: ImportSeed(),
    );
  }
}
