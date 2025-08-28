import 'package:flutter/material.dart';
import 'package:veil_wallet/src/generated/i18n/app_localizations.dart';

class LoadingLayout extends StatefulWidget {
  const LoadingLayout({super.key, @required this.child});

  final Widget? child;

  @override
  State<LoadingLayout> createState() => _LoadingLayoutState();
}

class _LoadingLayoutState extends State<LoadingLayout> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Semantics(
            label: AppLocalizations.of(context)?.loadingAppSemantics,
            child: Scaffold(
                appBar: AppBar(
                  //backgroundColor: Colors.transparent,
                  forceMaterialTransparency: true,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                ),
                extendBody: true,
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                  child: Container(child: widget.child),
                ))));
  }
}
