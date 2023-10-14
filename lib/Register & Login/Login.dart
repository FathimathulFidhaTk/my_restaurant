import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Admin/Admin_Homepage.dart';
import '../Customer/customer_home.dart';
import '../Kitchen/kitchen_drawer.dart';
import '../drawer/drawer_main.dart';
import 'Register.dart';

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
      home:  LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final validkey = GlobalKey<FormState>();
  var formkey = GlobalKey<FormState>();
  late final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  bool hidepass = true;
  bool showpass = true;

  void logincheck(String email, String password) async {
    if (email == 'admin@gmail.com' && password == '123456') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  AdminHome()));
    } else  if (email == 'kitchen@gmail.com' && password == '1234567') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  HomePage()));
    }
    else  {
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass.text).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (
            context) => liquidw()));
      });
    } }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
              key: formkey,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/splashscreen/login.jpeg"),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    left: 30,
                    top: 175,
                    child: Text("Login",
                        style: GoogleFonts.alegreya(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 35,
                          color: Colors.brown,
                        )),
                  ),
                  Positioned(
                    left: 30,
                    top: 220,
                    child: Text("Please Sign in to Continue",
                        style: GoogleFonts.alegreya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 20,
                            color: Colors.brown)),
                  ),
                  Positioned(
                      left: 30,
                      top: 265,
                      child: Container(
                        height: 55,
                        width: Get.width * 0.75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.brown)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email_outlined,color: Colors.brown),
                                hintText: ("Enter Email"),
                                hintStyle: TextStyle(height: 1.5,color: Colors.brown),
                                hintTextDirection: TextDirection.ltr,
                                border: InputBorder.none),
                            validator: (text) {
                              if (text!.isEmpty ||
                                  !text.contains('@') ||
                                  !text.contains(".")) {
                              }},
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      )),
                  Positioned(
                    left: 30,
                    top: 335,
                    child: Container(
                      height: 55,
                      width: Get.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.brown),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: pass,
                          obscureText: hidepass,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock,color: Colors.brown),
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
                                    : Icons.visibility,color: Colors.brown,),
                              ),
                              hintText: "Enter Password",
                              hintStyle: TextStyle(height: 1.6,color: Colors.brown),
                              border: InputBorder.none),
                          validator: (pass) {
                            if (pass!.isEmpty || pass.length < 6) {
                            }
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 45,
                    top: 400,
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
                        Icon(
                          Icons.toggle_on_rounded,
                          size: 35,
                          color: Colors.brown,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 445,
                    child: ElevatedButton(
                        onPressed: () {
                          final valid = formkey.currentState!.validate();
                          if (valid) {
                            logincheck(email.text, pass.text);
                          } else {}
                          // FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: pass.text).then((value) {
                          //   Navigator.push(context, MaterialPageRoute(builder: (
                          //       context) => KitchenMenu()));
                          // });
                        }
                        ,child: Text(
                      "Sign in",
                      style: GoogleFonts.alegreya(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(Get.width * 0.74, Get.height * 0.07),
                          primary: Colors.brown,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        )),
                  ),
                  Positioned(
                      left: 80,
                      top: 485,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register())),
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                    "Not a User? Register Here!!!",
                                    style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 16,
                                        color: Colors.brown))),
                          )
                        ],
                      )),
                ],
              )
          )),
    );
  }
}
