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
          centerTitle: true,
          leadingWidth: 61,
          leading: Row(children: [
            SizedBox(width: 5),
            IconButton(
              icon: const Icon(Icons.notifications_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: "Notifications",
            ),
            /*Container(
                width: 70,
                height: 28,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('./assets/images/logo_full_light.png'),
                        fit: BoxFit.fitWidth))),*/
          ]),
          title: Text(
            "Wallet",
            overflow: TextOverflow.ellipsis,
          ),
          /*title: Container(
              child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    icon: Icon(Icons.expand_more_outlined),
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black),
                    value: "main wallet",
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        child: new Text('main wallet'),
                        value: 'main wallet',
                      ),
                      DropdownMenuItem(child: new Text('two'), value: 'two'),
                    ],
                    onChanged: (String? value) {
                      //setState(() => _value = value);
                    },
                  )))),*/
          actions: [
            /*IconButton(
              icon: const Icon(Icons.notifications_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: "Notifications",
            ),*/
            /*IconButton(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {}, //null = disabled
              tooltip: "Scan QR",
            ),*/
            /*IconButton(
              icon: const Icon(Icons.settings_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              tooltip: "Settings",
            ),*/
            PopupMenuButton<int>(
              icon: Icon(Icons.wallet_rounded,
                  color: Theme.of(context).primaryColor),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Wallet')),
                PopupMenuItem<int>(value: 1, child: Text('Another wallet')),
              ],
            ),
            SizedBox(width: 10)
          ],
        ),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: Focus(
            autofocus: true,
            child: NavigationBar(destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_rounded),
                label: 'Explorer',
              ),
              NavigationDestination(
                icon: Icon(Icons.qr_code_scanner_rounded),
                label: 'Scan QR',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_rounded),
                label: 'Settings',
              ),
            ])),
        body: SafeArea(
          child: Container(child: widget.child),
        ));
  }
}
