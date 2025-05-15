import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  const AppText({super.key, required this.text, this.size = 27});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: size));
  }
}
