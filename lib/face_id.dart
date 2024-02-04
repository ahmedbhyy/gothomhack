import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gothomhack/add_cars.dart';
import 'package:local_auth/local_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum SupportState {
  unknown,
  supported,
  unSupported,
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;

  @override
  void initState() {
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportState =
            isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddCar()));
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Face recognition',
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Text(
              "For your security account you need to verify your face id ",
              style: GoogleFonts.belleza(
                  fontSize: 25,
                  color: const Color(0xff353392),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'images/faceid.png',
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 40),
          ElevatedButton(
            onPressed: authenticateWithBiometrics,
            child: const Text("Authenticate with Face ID"),
          )
        ],
      ),
    );
  }
}
