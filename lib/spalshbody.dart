import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gothomhack/auth/login.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff232325),
      body: Column(
        children: [
          Image.asset(
            "images/toyotapic.png",
            width: 500,
            height: 450,
            fit: BoxFit.cover,
            alignment: Alignment.topRight,
          ),
          Text(
            "GUARDIAN LOCK",
            style: GoogleFonts.barlow(
                fontSize: 40,
                fontStyle: FontStyle.italic,
                color: const Color(0xff15A3B7),
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "a cutting-edge car security app that empowers users to remotely arm, monitor, and receive instant alerts for any suspicious activity, ensuring the safety of their vehicles with seamless mobile control.",
              textAlign: TextAlign.center,
              style: GoogleFonts.barlow(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 214, 220, 221),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xff15A3B7),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: Text(
                  "Let's Go",
                  style: GoogleFonts.kreon(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: const Color.fromARGB(255, 214, 220, 221),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
