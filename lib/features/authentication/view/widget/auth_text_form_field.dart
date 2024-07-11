import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
