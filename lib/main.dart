import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gothomhack/add_cars.dart';

import 'package:gothomhack/auth/login.dart';
import 'package:gothomhack/auth/sign_up.dart';
import 'package:gothomhack/firebase_options.dart';
import 'package:gothomhack/home_page.dart';
import 'package:gothomhack/spalshbody.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GothomHack());
}

class GothomHack extends StatefulWidget {
  const GothomHack({super.key});

  @override
  State<GothomHack> createState() => _GothomhHackState();
}

class _GothomhHackState extends State<GothomHack> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade700)),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified)
          ? const HomePage()
          : const SplashBody(),
      routes: {
        "Login": (context) => const Login(),
        "SignUp": (context) => const SignUp(),
        "HomePage": (context) => const HomePage(),
        "SplashBody":(context)=> const SplashBody(),
        "AddCar":(context)=> const AddCar(),
      },
    );
  }
}
