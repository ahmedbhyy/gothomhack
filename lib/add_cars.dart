import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gothomhack/face_id.dart';
import 'package:gothomhack/qr_code.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  TextEditingController name = TextEditingController();
  CollectionReference cars = FirebaseFirestore.instance.collection('cars');
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;

  Future<void> addcar() {
    return cars
        .add({
          'name': name.text,
          'photo': "cardefault2",
        })
        .then((value) => print("car Added"))
        .catchError((error) => print("Failed to add car: $error"));
  }

  String _imageFile = '';
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New car",
          style: GoogleFonts.belleza(
              fontSize: 25,
              color: const Color(0xff353392),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              carphoto(),
              const SizedBox(height: 30),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Car brand",
                  hintStyle:
                      TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  prefixIcon: Icon(
                    Icons.car_repair,
                    size: 30,
                  ),
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QrScanner(),
                    ),
                  );
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 169, 142, 187),
                    width: 2.0,
                  ),
                ),
                child: const Text(
                  "Scan qr code",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 235, 219, 7)),
                ),
              ),
              const SizedBox(height: 50),
              MaterialButton(
                onPressed: () {
                  addcar();
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: 'success',
                      desc: 'A new car has been added successffly',
                      btnOkOnPress: () {
                        Navigator.of(context).pushNamed("HomePage");
                      }).show();
                },
                color: Colors.amber,
                minWidth: 200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 169, 142, 187),
                    width: 2.0,
                  ),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Image.asset(
                "images/appicon.png",
                width: 150,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carphoto() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 120.0,
          backgroundImage:
              _imageFile.isNotEmpty ? NetworkImage(_imageFile) : null,
          backgroundColor: Colors.grey,
          child: _imageFile.isNotEmpty
              ? null
              : const Icon(
                  Icons.car_repair,
                  color: Color.fromARGB(255, 124, 41, 179),
                  size: 105.0,
                ),
        ),
        Positioned(
          bottom: 20.0,
          right: 15.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 43.0,
            ),
          ),
        ),
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile.path;
        Navigator.pop(context);
      }
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Car photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: const Text("Gallery"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.no_photography_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: const Text("No image"),
            ),
          ])
        ],
      ),
    );
  }
}
