import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LastRides extends StatefulWidget {
  const LastRides({
    super.key,
  });

  @override
  State<LastRides> createState() => _LastRidesState();
}

class _LastRidesState extends State<LastRides> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Last Rides",
          style: GoogleFonts.belleza(
              fontSize: 30,
              color: const Color(0xff353392),
              fontWeight: FontWeight.bold),
        ),
        actions: [_buildDatePickerIconButton(context)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(date.toString()),
            const SizedBox(height: 30),
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
                          "Sup'com - Asjt\n(20km)",
                          style: GoogleFonts.belleza(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 39, 37, 151),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
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
                              fontSize: 20,
                              color: const Color(0xff353392),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          "average speed : 80 km/h",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.calendar_today,
        size: 24,
      ),
      onPressed: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }
}
