import 'package:flutter/material.dart';

class AppInputDecoration extends InputDecoration {
  const AppInputDecoration({super.hintText, super.prefixIcon})
      : super(
          filled: true,
          fillColor: const Color(0xffedeef2),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          errorMaxLines: 3,
        );
}
