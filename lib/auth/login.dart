// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:gothomhack/auth/sign_up.dart';
import 'package:gothomhack/components/button_register.dart';
import 'package:gothomhack/components/text_form.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final password = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  bool isloading = false;
  bool isPasswordHidden = true;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    isloading = true;
    setState(() {});
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("HomePage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xffE2E2E2),
                                    width: 2.0,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed("SplashBody");
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                "images/bmw.png",
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 1.5,
                          ),
                          child: Text(
                            "Sign in",
                            style: GoogleFonts.belleza(
                                fontSize: 35,
                                color: const Color(0xff353392),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1100),
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 7,
                          ),
                          child: Text(
                            "Please enter your login credentials below",
                            style: GoogleFonts.mulish(
                                fontSize: 15,
                                color: const Color(0xff565656),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1150),
                        child: TextForm(
                          title: "Username",
                          mycontroller: username,
                          validator: (val) {
                            if (val == "") {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: TextForm(
                          title: "Email",
                          mycontroller: email,
                          validator: (val) {
                            if (val == "") {
                              return "Can't to be empty ";
                            }
                            return null;
                          },
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffE2E2E2),
                              width: 1.0,
                            ),
                          ),
                          child: TextFormField(
                            controller: password,
                            obscureText: isPasswordHidden,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                                child: Icon(
                                  isPasswordHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                color: Color(0xff464646),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: InkWell(
                          onTap: () async {
                            if (email.text == "") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'ERROR',
                                desc: 'Email is empty. Please write your Email',
                              ).show();
                              return;
                            }
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'Reset Password',
                                desc:
                                    'An email was send to you. Please Reset your password !',
                              ).show();
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: 'Email not found. Please try again',
                              ).show();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 1.8),
                            child: Text(
                              "Forget Password?",
                              style: GoogleFonts.mulish(
                                  fontSize: 15,
                                  color: const Color(0xffE80707),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: Container(
                          width: 380,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xff353392),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              if (formState.currentState!.validate()) {
                                try {
                                  isloading = true;
                                  setState(() {});
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  isloading = false;
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                  if (credential.user!.emailVerified) {
                                    Navigator.of(context)
                                        .pushReplacementNamed("HomePage");
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      title: 'Email Verify',
                                      desc:
                                          'An email was send to you. Please verify your email by clicking on the link !',
                                    ).show();
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'ERROR',
                                      desc: 'No user found for that email.',
                                    ).show();
                                  } else if (e.code == 'wrong-password') {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      title: 'ERROR',
                                      desc:
                                          'Wrong password provided for that user.',
                                    ).show();
                                  }
                                }
                              } else {}
                            },
                            child: Text(
                              "sign in",
                              style: GoogleFonts.mulish(
                                  fontSize: 20,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 100,
                              height: 0.5,
                              color: Colors.grey,
                            ),
                            Text(
                              "Or continue with",
                              style: GoogleFonts.mulish(
                                fontSize: 19,
                                color: const Color(0xff666666),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 0.5,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1700),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 80,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xffE2E2E2),
                                  width: 1.0,
                                ),
                              ),
                              child: IconButton(
                                iconSize: 40,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: const ButtonRegister(
                                  path: "images/google.png"),
                            ),
                            const ButtonRegister(path: "images/appleicon.png"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not Registred? ",
                              style: GoogleFonts.mulish(
                                fontSize: 17,
                                color: const Color(0xff4D4D4D),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                );
                              },
                              child: Text(
                                "Create an account",
                                style: GoogleFonts.mulish(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff353392),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
