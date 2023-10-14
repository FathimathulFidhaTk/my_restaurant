import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Register & Login/Login.dart';
import '../Register & Login/Register.dart';


class ScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 40),
                child: Image.asset("assets/splashscreen/intro.jpeg",height: 340,),
              ),
              Positioned(
                  right: 150,
                  bottom: 1,
                  child: Text("Welcome To",
                    style: GoogleFonts.dancingScript(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 45,
                        color: Colors.brown),)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40,right: 10),
            child: Text("The Restaurant",
              style: GoogleFonts.dancingScript(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 45,
                  color: Colors.brown),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 10,top: 20),
            child: Text("We Serve Food that are made with Love and Cooked with Care.",
              style: GoogleFonts.laBelleAurore(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 24,
                  color: Colors.brown),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 40,top: 25),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 23,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width * 0.8,
                      Get.height * 0.06),
                  primary: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 40,top: 10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 23,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width * 0.8, Get.height * 0.06),
                  primary: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                )),
          )

        ],
      ),
    ));
  }
}