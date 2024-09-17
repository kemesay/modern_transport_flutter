// lib/widgets/gradient_button.dart

import 'package:flutter/material.dart';
import 'package:modern_transportation/pallete.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.label, // Add label parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // width: double.infinity, // Make the button full-width
        // padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Pallete.gradient1, Pallete.gradient2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
   child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: const Color.fromARGB(0, 9, 184, 56),
          shadowColor: const Color.fromARGB(0, 213, 16, 16),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 239, 236, 236),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // child: const Text(
        // label,
        //   style: TextStyle(
        //     fontWeight: FontWeight.w600,
        //     fontSize: 17,
        //   ),
        // ),
      ),
      ),
    );
  }
}
