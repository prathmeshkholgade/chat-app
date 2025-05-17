import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final bool isObscureText;
  final TextEditingController controller;
  final FormFieldValidator validator;
  const AuthField({
    super.key,
    required this.hint,
    this.isObscureText = false,
    required this.controller,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      validator: validator,
      obscureText: isObscureText,
    );
  }
}
