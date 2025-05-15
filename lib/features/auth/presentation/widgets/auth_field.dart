import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final bool isObscureText;
  final TextEditingController controller;
  const AuthField({super.key, required this.hint, this.isObscureText = false, required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      obscureText: isObscureText,
    );
  }
}
