import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

const phoneNumber = "98570038";

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();

    // Add a post-frame callback to automatically press the "Direct Call" button
    WidgetsBinding.instance.addPostFrameCallback((_) {
      makeDirectCall();
    });
  }

  void makeDirectCall() async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct Call Screen"),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            makeDirectCall();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.teal[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          icon: const Icon(Icons.phone, color: Colors.white, size: 20.0),
          label: const Text(
            "Direct Call",
            style: TextStyle(color: Colors.white, fontSize: 17.0),
          ),
        ),
      ),
    );
  }
}
