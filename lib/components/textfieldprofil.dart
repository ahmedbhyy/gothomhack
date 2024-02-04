import 'package:flutter/material.dart';

class TextProfil extends StatelessWidget {
  final TextEditingController controller;
   const TextProfil({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          focusColor: Colors.blue,
        ),
      ),
    );
  }
}
