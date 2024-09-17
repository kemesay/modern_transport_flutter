import 'package:flutter/material.dart';
import 'package:modern_transportation/pallete.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText; // Add obscureText property
  final Widget suffixIcon; // Accept any Widget for suffixIcon, not just IconButton

  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,  // Required for password visibility
    required this.suffixIcon,   // Required for adding an icon (like visibility toggle)
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText, // Set the obscureText property for password fields
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.gradient2,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          suffixIcon: suffixIcon, // Add the suffixIcon to InputDecoration
        ),
      ),
    );
  }
}
