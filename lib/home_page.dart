import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gothomhack/car_details.dart';

import 'package:gothomhack/components/card_car.dart';
import 'package:gothomhack/face_id.dart';
import 'package:gothomhack/profil.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum SupportState {
  unknown,
  supported,
  unSupported,
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cars').get();
    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("show your face");
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("show your face");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint or Face ID',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));

      if (!mounted) {
        return;
      }

      if (authenticated) {
        Navigator.of(context).pushNamed("AddCar");
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }

  @override
  void initState() {
    getData();
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportState =
            isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
    super.initState();
  }

  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AuthScreen()));
        },
        backgroundColor: const Color(0xff353392),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello\nMember",
                      style: GoogleFonts.belleza(
                          fontSize: 25,
                          color: const Color(0xff353392),
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profil()));
                      },
                      child: const CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Color.fromARGB(255, 207, 201, 225),
                        child: Icon(
                          Icons.person,
                          color: Colors.teal,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                  style: const TextStyle(
                      fontSize: 17.0, color: Color.fromARGB(255, 3, 3, 3)),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    labelText: "Search a Car",
                    labelStyle:
                        const TextStyle(color: Color.fromARGB(255, 2, 15, 75)),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xffB84E21)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 1.5,
                ),
                child: Text(
                  "My Cars",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.belleza(
                    fontSize: 30,
                    color: const Color.fromARGB(255, 93, 92, 114),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              isloading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.question,
                                animType: AnimType.rightSlide,
                                title: 'Confirme Delete',
                                desc: 'Are you sure to delete this car ? ',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () async {
                                  await FirebaseFirestore.instance
                                      .collection("cars")
                                      .doc(data[index].id)
                                      .delete();
                                  Navigator.of(context).pushNamed("HomePage");
                                },
                              ).show();
                            },
                            child: CardCars(
                              title: data[index]["name"],
                              source: "images/${data[index]["photo"]}.png",
                              child: CarDetails(
                                name: data[index]["name"],
                                img: "images/${data[index]["photo"]}.png",
                                location: data[index]["location"],
                                driversnum: data[index]["driversnum"],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
