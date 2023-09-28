import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, @required this.child});

  final Widget? child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          centerTitle: false,

          /*leading: IconButton(
              icon: const Icon(Icons.notifications_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {}),*/
          title: Container(
              width: 70,
              height: 28,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('./assets/images/logo_full_light.png'),
                      fit: BoxFit.fitHeight))),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: null,
              tooltip: "Notifications",
            ),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: null,
              tooltip: "Scan QR",
            ),
            IconButton(
              icon: const Icon(Icons.settings_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: "Settings",
            )
          ],
        ),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(child: widget.child),
        ));
  }
}
