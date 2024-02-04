import 'package:flutter/material.dart';
import 'package:flutter_popup_menu_button/menu_direction.dart';
import 'package:flutter_popup_menu_button/menu_icon.dart';
import 'package:flutter_popup_menu_button/menu_item.dart';
import 'package:flutter_popup_menu_button/popup_menu_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gothomhack/camera_state.dart';
import 'package:gothomhack/car_details2.dart';
import 'package:gothomhack/components/card_car_details.dart';
import 'package:gothomhack/drivers.dart';
import 'package:gothomhack/home_page.dart';
import 'package:gothomhack/last_rides.dart';
import 'package:gothomhack/manage_pic.dart';
import 'package:gothomhack/maps.dart';

class CarDetails extends StatelessWidget {
  final String name;
  final String driversnum;
  final String img;
  final String location;

  const CarDetails({
    super.key,
    required this.name,
    required this.img,
    required this.location,
    required this.driversnum,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Color(0xff95BCCC),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("HomePage");
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        FlutterPopupMenuButton(
                          direction: MenuDirection.left,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xff95BCCC),
                          ),
                          popupMenuSize: const Size(250, 160),
                          child: FlutterPopupMenuIcon(
                            key: GlobalKey(),
                            child: const Icon(
                              Icons.more_vert,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 35,
                            ),
                          ),
                          children: [
                            FlutterPopupMenuItem(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ManagePic(),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: const Text(
                                  'Manage Pictures',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                leading: Image.asset(
                                  "images/camera.png",
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                            FlutterPopupMenuItem(
                              child: ListTile(
                                title: const Text(
                                  'Deleta Car',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                leading: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Image.asset("images/deleta.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    img,
                    width: 350,
                    height: 320,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  name,
                  style: GoogleFonts.belleza(
                      fontSize: 25,
                      color: const Color(0xff353392),
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    Text(
                      location,
                      style: GoogleFonts.belleza(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 255, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardDrivers(
                  title: "Drivers",
                  title2: driversnum,
                  child: const Drivers(),
                ),
                const CardDrivers(
                    title: "Last Rides",
                    title2: "See more",
                    child: LastRides()),
                const CardDrivers(
                  title: "Car Details",
                  title2: "See more Details",
                  child: CarDetailss(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 200,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MapScreen()));
              },
              color: const Color(0xffDED7EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color.fromARGB(255, 169, 142, 187),
                  width: 2.0,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Open map",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 201, 20, 20),
                    ),
                  ),
                  Icon(Icons.map_outlined),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Camera()));
              },
              color: const Color(0xffDED7EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Color.fromARGB(255, 169, 142, 187),
                  width: 2.0,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Camera",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 201, 20, 20),
                    ),
                  ),
                  Icon(Icons.camera),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
