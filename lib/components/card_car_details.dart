import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDrivers extends StatelessWidget {
  final String title;
  final String title2;
  final Widget child;
  const CardDrivers(
      {super.key,
      required this.title,
      required this.title2,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => child),
        );
      },
      child: SizedBox(
        width: 260,
        height: 160,
        child: Card(
          margin: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 255, 250, 250),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Color.fromARGB(255, 169, 142, 187),
              width: 1.0,
            ),
          ),
          shadowColor: Colors.grey[700],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(title,
                  style: GoogleFonts.belleza(
                    fontSize: 26,
                    color: const Color.fromARGB(255, 109, 164, 185),
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                title2,
                textAlign: TextAlign.center,
                style: GoogleFonts.belleza(
                  fontSize: 22,
                  color: const Color.fromARGB(255, 119, 89, 89),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
