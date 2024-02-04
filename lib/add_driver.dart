import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gothomhack/components/appbar.dart';

import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthday = TextEditingController();
  String _imageFile = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  CollectionReference cars = FirebaseFirestore.instance.collection('users');

  Future<void> adddriver() {
    return cars
        .add({
          'name': name.text,
          'phone': phone.text,
          'birthday': birthday.text,
        })
        .then((value) => print("driver Added"))
        .catchError((error) => print("Failed to add driver: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CommunBar(title: "New Driver"),
              CircleAvatar(
                radius: 100.0,
                backgroundImage:
                    _imageFile.isNotEmpty ? NetworkImage(_imageFile) : null,
                backgroundColor: Colors.white,
                child: _imageFile.isNotEmpty
                    ? null
                    : Image.asset(
                        'images/faceid.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                "How to Set Up Face ID",
                style: GoogleFonts.belleza(
                    fontSize: 30,
                    color: const Color(0xff95BCCC),
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "First, position  driver face in the camera frame. Then move driver head in a circle to show all the angles of driver face.",
                  style: GoogleFonts.belleza(
                      fontSize: 19,
                      color: const Color.fromARGB(255, 129, 165, 117),
                      fontWeight: FontWeight.bold),
                ),
              ),
              MaterialButton(
                minWidth: 150,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 169, 142, 187),
                    width: 2.0,
                  ),
                ),
                color: const Color.fromARGB(255, 138, 206, 220),
                onPressed: () {
                  takePhoto2(ImageSource.camera);
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Full name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: birthday,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: "Birth day",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                minWidth: 150,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 169, 142, 187),
                    width: 2.0,
                  ),
                ),
                color: const Color.fromARGB(255, 138, 206, 220),
                onPressed: () {
                  adddriver();
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Success',
                    desc: 'Driver added successffly',
                    btnOkOnPress: () {
                      Navigator.of(context).pushNamed("HomePage");
                    },
                  ).show();
                },
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  Future<void> takePhoto2(ImageSource source) async {
    final newpicdriver = FirebaseAuth.instance.currentUser!.uid;
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 20,
    );
    if (((pickedFile?.path) ?? '').isNotEmpty) {
      String path = pickedFile!.path;
      File file = File(path);
      final store = FirebaseStorage.instance.ref();
      final pdpref = store.child("profil/$newpicdriver.jpg");
      await pdpref.putFile(file);
      path = await pdpref.getDownloadURL();
      setState(() {
        _imageFile = path;
      });
      return;
    }
  }
}
