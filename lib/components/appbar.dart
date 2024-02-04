import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunBar extends StatelessWidget {
  final String title;

  const CommunBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: Text(
              title,
              style: GoogleFonts.belleza(
                  fontSize: 34,
                  color: const Color(0xff95BCCC),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
