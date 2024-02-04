import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String title;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  const TextForm(
      {super.key,
      required this.title,
      required this.mycontroller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffE2E2E2),
          width: 1.0,
        ),
      ),
      child: TextFormField(
        validator: validator,
        controller: mycontroller,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(
            color: Color(0xff464646),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
