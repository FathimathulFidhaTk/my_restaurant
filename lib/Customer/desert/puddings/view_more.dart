import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Customer/appt/foodfingers/view_order.dart';
import 'package:my_restaurant/Customer/burger/view_order.dart';
import 'package:my_restaurant/Customer/desert/puddings/view_order.dart';
import 'package:path/path.dart' as path;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PuddingPage extends StatefulWidget {
  final String foodName;
  final String foodDescription;
  final String foodDocumentId;
  final String imageUrl;


  PuddingPage(this.foodName, this.foodDescription, this.foodDocumentId, this.imageUrl);

  @override
  State<PuddingPage> createState() => _PuddingPageState();
}

class _PuddingPageState extends State<PuddingPage> {

  FirebaseStorage storage = FirebaseStorage.instance;

  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
      // Update the Firestore document with the new quantity
      FirebaseFirestore.instance
          .collection('pudding')
          .doc(widget.foodDocumentId)
          .update({
        'quantity': quantity,
      });
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        // Update the Firestore document with the new quantity
        FirebaseFirestore.instance
            .collection('pudding')
            .doc(widget.foodDocumentId)
            .update({
          'quantity': quantity,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                      height: Get.height * 0.85,
                      width: Get.width * 1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.brown),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(10, 10),
                                blurRadius: 20,
                                color: Colors.transparent.withOpacity(1))
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: Text(widget.foodName,
                                style: GoogleFonts.alegreya(
                                    textStyle:
                                    Theme.of(context).textTheme.headline4,
                                    fontSize: 26,
                                    color: Colors.brown)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 15),
                            child: Text(widget.foodDescription,
                                style: GoogleFonts.alegreya(
                                    textStyle:
                                    Theme.of(context).textTheme.headline4,
                                    fontSize: 18,
                                    color: Colors.brown)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Row(
                              children: <Widget>[
                                Text('Quantity: $quantity',
                                    style: GoogleFonts.alegreya(
                                        textStyle:
                                        Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown)),
                                SizedBox(width: 20),
                                ElevatedButton(
                                    onPressed: incrementQuantity,
                                    child: Icon(Icons.add),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                      Size(Get.width * 0.1, Get.height * 0.04),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: decrementQuantity,
                                    child: Icon(Icons.remove),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                      Size(Get.width * 0.1, Get.height * 0.04),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 6),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PuddingOrderPage(
                                                  widget.foodName,
                                                  widget.foodDescription,
                                                  quantity,
                                                  widget.imageUrl
                                              ),
                                        ),
                                      );
                                    },
                                    child: Text('Order now'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                      Size(Get.width * 0.35, Get.height * 0.05),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                    )),
                                SizedBox(
                                  width: 35,
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Cancel'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                      Size(Get.width * 0.35, Get.height * 0.05),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
