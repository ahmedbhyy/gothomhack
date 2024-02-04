import 'package:flutter/material.dart';

class ManagePic extends StatefulWidget {
  const ManagePic({super.key});

  @override
  State<ManagePic> createState() => _ManagePicState();
}

class _ManagePicState extends State<ManagePic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                        );
                      },
                      icon: const Icon(Icons.add_a_photo_outlined)),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            const Text(
              "No Pictures added!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
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
            "Add Car photos",
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
          ])
        ],
      ),
    );
  }
}
