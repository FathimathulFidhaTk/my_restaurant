import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CakePage extends StatefulWidget {
  final String foodName;
  final String foodDescription;
  final String foodDocumentId;
  final String imageUrl;
  final String foodPrice;


  CakePage(this.foodName, this.foodDescription, this.foodDocumentId, this.imageUrl,this.foodPrice);

  @override
  State<CakePage> createState() => _CakePageState();
}

class _CakePageState extends State<CakePage> {

  FirebaseStorage storage = FirebaseStorage.instance;

  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
      FirebaseFirestore.instance
          .collection('cake')
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
        FirebaseFirestore.instance
            .collection('cake')
            .doc(widget.foodDocumentId)
            .update({
          'quantity': quantity,
        });
      });
    }
  }

  Future<void> _placeOrder() async {
    final img = widget.imageUrl;
    final name = widget.foodName;
    final price = widget.foodPrice;
    final qty = quantity;
    final description = widget.foodDescription;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('food orders').add({
      'imageUrl': img,
      'orderDate': Timestamp.now(),
      'food Name': name,
      'food Price': price,
      'Quantity': qty,
      'food description': description,
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
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
                            width: screenWidth,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(widget.imageUrl),
                                  fit: BoxFit.cover,
                                )),
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
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 22,
                                        color: Colors.brown)),
                                SizedBox(width: 20),
                                ElevatedButton(
                                    onPressed: incrementQuantity,
                                    child: Icon(Icons.add),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          Get.width * 0.1, Get.height * 0.04),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8)),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: decrementQuantity,
                                    child: Icon(Icons.remove),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          Get.width * 0.1, Get.height * 0.04),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8)),
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
                                      _placeOrder();
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.brown,
                                        content: Text(
                                          'Food ordered successfully!',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(
                                            seconds:
                                            3), // Optional: Set the duration
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Text('Order now'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          Get.width * 0.35, Get.height * 0.05),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8)),
                                    )),
                                SizedBox(
                                  width: 35,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                          Get.width * 0.35, Get.height * 0.05),
                                      primary: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8)),
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
