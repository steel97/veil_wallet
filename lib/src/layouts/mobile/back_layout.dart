import 'package:flutter/material.dart';

class BackLayout extends StatefulWidget {
  const BackLayout({super.key, @required this.child, @required this.title});

  final Widget? child;
  final String? title;

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
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.chevron_left_rounded),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {}),
          title: Text(widget.title ?? ""),
        ),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(child: widget.child),
        ));
  }
}
