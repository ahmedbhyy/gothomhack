import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:gothomhack/add_driver.dart';
import 'package:gothomhack/components/appbar.dart';
import 'package:gothomhack/components/card_car.dart';

import 'package:gothomhack/driver_details.dart';

class Drivers extends StatefulWidget {
  const Drivers({super.key});

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  bool isloading = true;
  String _imageFile = '';
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    final newpicdriver = FirebaseAuth.instance.currentUser!.uid;
    final store = FirebaseStorage.instance.ref();
    final pdpref = store.child("profil/$newpicdriver.jpg");
    try {
      pdpref.getDownloadURL().then((value) {
        setState(() {
          _imageFile = value;
        });
      }, onError: (val) {});
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "une erreur est survenue veuillez réessayer ultérieurement")));
    }
    getData();
    super.initState();
  }

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
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CommunBar(title: "Drivers"),
            ),
            isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
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
                              desc: 'Are you sure to delete this Driver ? ',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(data[index].id)
                                    .delete();
                                Navigator.of(context).pop();
                              },
                            ).show();
                          },
                          child: CardCars(
                            title: data[index]["name"],
                            source: "images/${data[index]["photo"]}.jpg",
                            child: DriverDetail(
                              title: data[index]["name"],
                              photo: data[index]["photo"],
                              fullname: data[index]["fullname"],
                              birthday: data[index]["birthday"],
                              phone: data[index]["phone"],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
