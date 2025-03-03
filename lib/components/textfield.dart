import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final Function(String?)? onChanged;

  final String? errorMsg;
  final String? Function(String?)? validator;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,

    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorMsg,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color:
                Theme.of(
                  context,
                ).colorScheme.secondary,
          ),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
