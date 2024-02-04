import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gothomhack/components/text_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final password = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  bool isPasswordHidden2 = true;
  String? validatePassword(String? value) {
    if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Builder(
            builder: (BuildContext context) {
              return Form(
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
                                    Navigator.of(context).pushNamed("Login");
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
                              "images/range.png",
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
                          "Sign up",
                          style: GoogleFonts.belleza(
                              fontSize: 35,
                              color: const Color(0xff353392),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1100),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
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
                    FadeInUp(
                      duration: const Duration(milliseconds: 1400),
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
                          controller: confirmPassword,
                          validator: validatePassword,
                          obscureText: isPasswordHidden2,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordHidden2 = !isPasswordHidden2;
                                });
                              },
                              child: Icon(
                                isPasswordHidden2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: "Confirm password",
                            hintStyle: const TextStyle(
                              color: Color(0xff464646),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1600),
                      child: Container(
                        width: 380,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xff353392),
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            if (!formState.currentState!.validate()) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'ERROR',
                                desc: 'Passwords do not match',
                              ).show();
                            }
                            if (formState.currentState!.validate()) {
                              try {
                                // ignore: unused_local_variable
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .pushReplacementNamed("Login");
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  // ignore: use_build_context_synchronously
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'ERROR',
                                    desc: 'The password provided is too weak.',
                                  ).show();
                                } else if (e.code == 'email-already-in-use') {
                                  // ignore: use_build_context_synchronously
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'ERROR',
                                    desc:
                                        'The account already exists for that email.',
                                  ).show();
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          child: Text(
                            "sign up",
                            style: GoogleFonts.mulish(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1700),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account Already? ",
                            style: GoogleFonts.mulish(
                              fontSize: 17,
                              color: const Color(0xff4D4D4D),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("Login");
                            },
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.mulish(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff353392),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: Image.asset(
                        "images/ourlogo.jpg",
                        width: 150,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
