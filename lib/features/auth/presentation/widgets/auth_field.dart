import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AuthField extends StatelessWidget {
  final String hint;
  final bool isObscureText;
  final TextEditingController controller;
  final FormFieldValidator validator;
  late TextInputType keyboardType;
  late List<TextInputFormatter>? inputFormatters;
   AuthField({
    super.key,
    required this.hint,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.validator,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      validator: validator,
      obscureText: isObscureText,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
    );
  }
}
