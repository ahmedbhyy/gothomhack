import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  final String path;
  const ButtonRegister({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffE2E2E2),
          width: 1.0,
        ),
      ),
      child: Image.asset(path),
    );
  }
}
