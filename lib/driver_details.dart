import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gothomhack/components/appbar.dart';

class DriverDetail extends StatefulWidget {
  final String title;
  final String photo;
  final String fullname;
  final String birthday;
  final String phone;
  const DriverDetail(
      {super.key,
      required this.title,
      required this.photo,
      required this.fullname,
      required this.birthday,
      required this.phone});

  @override
  State<DriverDetail> createState() => _DriverDetailState();
}

class _DriverDetailState extends State<DriverDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommunBar(title: widget.title),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    10.0), // Adjust the border radius as needed
                child: Image.asset(
                  "images/${widget.photo}.jpg",
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 1.5, top: 20),
              child: Text(
                "Full Name",
                style: GoogleFonts.belleza(
                    fontSize: 23,
                    color: const Color.fromARGB(255, 96, 99, 101),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: widget.fullname,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 1.8),
              child: Text(
                "Phone Number",
                style: GoogleFonts.belleza(
                    fontSize: 23,
                    color: const Color.fromARGB(255, 96, 99, 101),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: widget.phone,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 1.5),
              child: Text(
                "Birth day",
                style: GoogleFonts.belleza(
                    fontSize: 23,
                    color: const Color.fromARGB(255, 96, 99, 101),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: widget.birthday,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {},
              color: const Color.fromARGB(255, 96, 99, 101),
              minWidth: 200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color.fromARGB(255, 169, 142, 187),
                  width: 2.0,
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color.fromARGB(255, 201, 180, 180),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
