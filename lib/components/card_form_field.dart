import 'package:flutter/material.dart';

class CardFormField extends StatelessWidget {
  final Widget? child;
  const CardFormField({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: child,
    );
  }
}
