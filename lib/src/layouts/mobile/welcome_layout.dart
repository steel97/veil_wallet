import 'package:flutter/material.dart';

class WelcomeLayout extends StatefulWidget {
  const WelcomeLayout({super.key, @required this.child});

  final Widget? child;

  @override
  State<WelcomeLayout> createState() => _WelcomeLayoutState();
}

class _WelcomeLayoutState extends State<WelcomeLayout> {
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
              icon: const Icon(Icons.settings_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: "Settings",
            ),
            SizedBox(width: 10)
          ],
        ),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(child: widget.child),
        ));
  }
}
