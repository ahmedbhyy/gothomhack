import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup_menu_button/menu_direction.dart';
import 'package:flutter_popup_menu_button/menu_icon.dart';
import 'package:flutter_popup_menu_button/menu_item.dart';
import 'package:flutter_popup_menu_button/popup_menu_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gothomhack/components/textfieldprofil.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final String _imageFile = '';
  TextEditingController fullname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController birthday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 80, 14, 14),
                image: DecorationImage(
                  opacity: 1,
                  image: AssetImage('images/profilpic1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
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
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          FlutterPopupMenuButton(
                            direction: MenuDirection.left,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xff95BCCC),
                            ),
                            popupMenuSize: const Size(250, 150),
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
                                onTap: () {},
                                child: ListTile(
                                  title: const Text(
                                    'Change language',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  leading: Image.asset(
                                    "images/translate.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ),
                              FlutterPopupMenuItem(
                                onTap: () async {
                                  GoogleSignIn googleSignIn = GoogleSignIn();
                                  googleSignIn.disconnect();
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "Login", (route) => false);
                                },
                                child: ListTile(
                                  title: const Text(
                                    'Log Out',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  leading: Image.asset("images/logout.png"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    profilphoto(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 1.5,
              ),
              child: Text(
                "Full Name",
                style: GoogleFonts.belleza(
                  fontSize: 21,
                  color: const Color.fromARGB(255, 93, 92, 114),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextProfil(controller: fullname),
            Container(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 1.7, top: 15),
              child: Text(
                "Phone Number",
                style: GoogleFonts.belleza(
                  fontSize: 21,
                  color: const Color.fromARGB(255, 93, 92, 114),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextProfil(controller: phonenumber),
            Container(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 1.5, top: 15),
              child: Text(
                "Birth Day",
                style: GoogleFonts.belleza(
                  fontSize: 21,
                  color: const Color.fromARGB(255, 93, 92, 114),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextProfil(controller: birthday),
            const SizedBox(height: 40),
            MaterialButton(
              onPressed: () {},
              color: const Color.fromARGB(255, 172, 98, 98),
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
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profilphoto() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage:
              _imageFile.isNotEmpty ? NetworkImage(_imageFile) : null,
          backgroundColor: const Color.fromARGB(255, 172, 98, 98),
          child: _imageFile.isNotEmpty
              ? null
              : const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 101, 71, 117),
                  size: 105.0,
                ),
        ),
        Positioned(
          bottom: 13.0,
          right: 5.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 197, 186, 186),
              size: 35.0,
            ),
          ),
        ),
      ]),
    );
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
