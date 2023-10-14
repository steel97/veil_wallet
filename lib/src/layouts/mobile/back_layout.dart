import 'package:flutter/material.dart';
import 'package:veil_wallet/src/helpers/responsive.dart';

typedef VoidCallback = void Function();

class BackLayout extends StatefulWidget {
  const BackLayout(
      {super.key, @required this.child, @required this.title, this.back});

  final Widget? child;
  final String? title;
  final VoidCallback? back;

  @override
  State<BackLayout> createState() => _BackLayoutState();
}

class _BackLayoutState extends State<BackLayout> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var backFunc = widget.back;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Semantics(
            label: widget.title,
            child: Scaffold(
                appBar: AppBar(
                  //backgroundColor: Colors.transparent,
                  forceMaterialTransparency: true,
                  centerTitle: true,
                  leading: IconButton(
                      icon: const Icon(Icons.chevron_left_rounded),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: backFunc),
                  title: Text(widget.title ?? ''),
                ),
                extendBody: true,
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                  child: Center(
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: responsiveMaxMainWidth),
                          child: widget.child)),
                ))));
  }
}
