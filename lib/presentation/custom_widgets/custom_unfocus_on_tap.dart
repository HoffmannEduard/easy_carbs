import 'package:flutter/material.dart';

class CustomUnfocusOnTap extends StatelessWidget {
  final Widget child;

  const CustomUnfocusOnTap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}