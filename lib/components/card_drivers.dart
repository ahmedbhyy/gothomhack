import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardCars extends StatelessWidget {
  final String title;
  final String source;
  final Widget child;

  const CardCars(
      {Key? key,
      required this.title,
      required this.source,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => child));
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color.fromARGB(255, 169, 142, 187),
            width: 2.0,
          ),
        ),
        shadowColor: Colors.grey[800],
        child: Column(
          children: [
            Image.asset(
              source,
              width: 50,
              height: 50,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.belleza(
                fontSize: 25,
                color: const Color.fromARGB(255, 93, 92, 114),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
