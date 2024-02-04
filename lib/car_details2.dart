import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gothomhack/components/appbar.dart';

class CarDetailss extends StatefulWidget {
  const CarDetailss({super.key});

  @override
  State<CarDetailss> createState() => _CarDetailssState();
}

class _CarDetailssState extends State<CarDetailss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommunBar(title: "Car details"),
            Row(
              children: [
                Image.asset(
                  "images/range2.png",
                  width: 250,
                  height: 200,
                ),
                const SizedBox(width: 20),
                Text(
                  "RANGE ROVER\nOwner : AJST",
                  style: GoogleFonts.belleza(
                      fontSize: 17,
                      color: const Color(0xff353392),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "Model:                  Range Rover",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Year:                      2019",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "color:                    White",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Mileage:                   140555 mi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: const EdgeInsets.only(right: 200, top: 20),
              child: Text(
                "Service History:",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            Container(
              width: 400,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff97A0E9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Tunis",
                          style: GoogleFonts.belleza(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 39, 37, 151),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "10:30 - 11:20",
                          style: GoogleFonts.belleza(
                              fontSize: 15,
                              color: const Color(0xff353392),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "Service performed at: 50055 km",
                          style: GoogleFonts.belleza(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 233, 217, 3),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
