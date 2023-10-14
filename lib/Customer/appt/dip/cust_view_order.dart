import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPage extends StatefulWidget {
  final String foodName;
  final String foodDescription;
  final int foodQuantity;
  final String imageUrl;


  OrderPage(this.foodName, this.foodDescription, this.foodQuantity,this.imageUrl);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  FirebaseStorage storage = FirebaseStorage.instance;


  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15,right: 15,top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.85,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(10,10),
                        blurRadius: 20,
                        color: Colors.transparent.withOpacity(1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: Get.height * 0.51,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(image:
                              NetworkImage(widget.imageUrl),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,top: 8),
                          child: Text('${widget.foodName}',style: GoogleFonts.alegreya(
                              textStyle:
                              Theme.of(context).textTheme.headline4,
                              fontSize: 24,
                              color: Colors.brown)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text('qty: ${widget.foodQuantity}',style: GoogleFonts.alegreya(
                              textStyle:
                              Theme.of(context).textTheme.headline4,
                              fontSize: 20,
                              color: Colors.brown)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15,top: 4),
                          child: Text('${widget.foodDescription}',style: GoogleFonts.alegreya(
                              textStyle:
                              Theme.of(context).textTheme.headline4,
                              fontSize: 20,
                              color: Colors.brown)),
                        ),
                        Text('')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


