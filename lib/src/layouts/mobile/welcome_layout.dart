import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/core/screen.dart';
import 'package:veil_wallet/src/states/static/base_static_state.dart';
import 'package:veil_wallet/src/views/settings.dart';

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
          automaticallyImplyLeading: false,

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
              onPressed: () {
                BaseStaticState.prevScreen = Screen.welcome;
                BaseStaticState.useHomeBack = false;
                Navigator.of(context).push(_createSettingsRoute());
              },
              tooltip: AppLocalizations.of(context)?.settingsButton,
            ),
            const SizedBox(width: 10)
          ],
        ),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(child: widget.child),
        ));
  }
}

Route _createSettingsRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Settings(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
