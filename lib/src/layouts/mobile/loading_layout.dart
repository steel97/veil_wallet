import 'package:flutter/material.dart';

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
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(child: widget.child),
        ));
  }
}
