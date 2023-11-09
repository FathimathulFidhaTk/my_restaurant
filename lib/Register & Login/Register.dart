import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home:  Register(),
    );
  }
}
class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formkey1 = GlobalKey<FormState>();
  var conname = TextEditingController();
  var conemail = TextEditingController();
  var pass = TextEditingController();
  var cpass = TextEditingController();
  bool hidepass = true;

  bool isToggled = false;

  void _toggleButton() {
    setState(() {
      isToggled = !isToggled;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: Form(
            key: formkey1,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // border: Border.all(width: 5),
                      image: DecorationImage(
                          image: AssetImage("assets/splashscreen/login.jpeg"),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  left: 30,
                  top: 130,
                  child: Text("Register",
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 35,
                        color: Colors.brown,
                      )),
                ),
                Positioned(
                  left: 30,
                  top: 175,
                  child: Text("Please register to Login....",
                      style: GoogleFonts.alegreya(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 20,
                          color: Colors.brown)),
                ),
                Positioned(
                    left: 30,
                    top: 225,
                    child: Container(
                      height: 55,
                      width: Get.width * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.brown)),
                      child: Center(
                        child: TextFormField(
                          controller: conname,
                          validator: (name) {
                            if (name!.isEmpty) {
                              return "Name is required";
                            } else
                              return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined,color: Colors.brown),
                              hintText: "Enter Name",
                              hintStyle: TextStyle(height: 1.5,color: Colors.brown),
                              border: InputBorder.none),
                        ),
                      ),
                    )),
                Positioned(
                  left: 30,
                  top: 295,
                  child: Container(
                    height: 55,
                    width: Get.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.brown)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: conemail,
                        validator: (email) {
                          if (email!.isEmpty &&
                              email.contains("@") &&
                              email.contains(".")) {
                            return "Enter valid email";
                          } else
                            return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined,color: Colors.brown),
                            hintText: "Enter Email",
                            hintStyle: TextStyle(height: 1.5,color: Colors.brown),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 365,
                  child: Container(
                    height: 55,
                    width: Get.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.brown)),
                    child: Center(
                      child: TextFormField(
                        validator: (pass1) {
                          if (pass1!.isEmpty || pass1.length < 6) {
                            return "Password must should be greater than 6";
                          } else
                            return null;
                        },
                        textInputAction: TextInputAction.next,
                        controller: pass,
                        obscuringCharacter: '*',
                        obscureText: hidepass,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password_outlined,color: Colors.brown),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (hidepass)
                                    hidepass = false;
                                  else
                                    hidepass = true;
                                });
                              },
                              icon: Icon(hidepass
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility,color: Colors.brown),
                            ),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(height: 1.5,color: Colors.brown),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 440,
                  child: Container(
                    height: 55,
                    width: Get.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.brown),
                    ),
                    child: Center(
                      child: TextFormField(
                        validator: (pass1) {
                          if (pass1!.isEmpty || pass1.length < 6) {
                            return "Password must should be greater than 6";
                          } else if (pass.text != cpass.text) {
                            return "Password not matched";
                          } else
                            return null;
                        },
                        textInputAction: TextInputAction.next,
                        controller: cpass,
                        obscuringCharacter: '*',
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline,color: Colors.brown),
                            hintText: "Enter Confirm Password",
                            hintStyle: TextStyle(height: 1.5,color: Colors.brown),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 45,
                  top: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Remainder me next time',
                      style: GoogleFonts.alegreya(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 16,
                          color: Colors.brown)
                      ),
                      SizedBox(
                        width: 55,
                      ),
                      IconButton(
                        icon: Icon(
                          isToggled ? Icons.toggle_on_rounded : Icons.toggle_off_outlined,
                          color: Colors.brown,
                        ),
                        onPressed: _toggleButton,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 545,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(Get.width * 0.74, Get.height * 0.07),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        primary: Colors.brown),
                    onPressed: () async {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: conemail.text, password: pass.text).then((value){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      }).onError((error, stackTrace){
                        print("Error");
                      });
                        },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20,
                      color: Colors.white)
                    ),
                  ),
                ),
                Positioned(
                    left: 60,
                    top: 585,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage())),
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Already have account? Sign in!!!",
                                style: GoogleFonts.alegreya(
                                textStyle: Theme.of(context).textTheme.headline4,
                                fontSize: 16,
                                color: Colors.brown,
                                fontWeight: FontWeight.bold)
                              ),
                            ))
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}
