import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Customer/customer_home.dart';
import 'package:my_restaurant/Kitchen/foodorder.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/dip/view_added_food.dart';
import 'package:path/path.dart' as path;

import '../../../Customer/HomeScreen.dart';

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
      home: ViewMore(),
    );
  }
}



class ViewMore extends StatefulWidget {
  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
      });
    });

    return files;
  }

  final CollectionReference menu = FirebaseFirestore.instance.collection('food menu');

  TextEditingController qty = TextEditingController();

  void addFood(){
    final data = {
      'quantity':qty.text,
    };

    menu.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:StreamBuilder(
            stream: menu.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 40,left: 30,right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.49
                        ),
                        itemCount: snapshot.data!.docs.length ?? 1 ,
                        itemBuilder: (context,index){
                          final DocumentSnapshot foodsnap = snapshot.data!.docs[index];
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(10,10),
                                      blurRadius: 20,
                                      color: Colors.brown.withOpacity(0.6)
                                  )
                                ]
                            ),

                            height: Get.height * 0.1,
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: FutureBuilder(
                                    future: _loadImages(),
                                    builder: (context,
                                        AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        return ListView.builder(
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: (context, index) {
                                            final Map<String, dynamic> image =
                                            snapshot.data![index];
                                            return Card(
                                                margin: const EdgeInsets.symmetric(vertical: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Image.network(image['url'],fit: BoxFit.cover,),
                                                )
                                            );
                                          },
                                        );
                                      }

                                      return Container();
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 20),
                                  child: Text(foodsnap['name'],style: GoogleFonts.alegreya(
                                    textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 22,
                                    color: Colors.brown,),),
                                ), Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 20),
                                  child:Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text('\$',style: TextStyle(fontSize: 16,color: Colors.brown),),
                                      ),SizedBox(width: 4,),
                                      Text(foodsnap['price'],style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 24,
                                        color: Colors.brown,),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8,right: 15),
                                  child: TextField(
                                    controller: qty,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Quantity',
                                      hintStyle:  GoogleFonts.alegreya(
                                      textStyle: Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,),
                                    ),
                                  ),
                                ),SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 20),
                                  child: Text(foodsnap['description'],style: GoogleFonts.alegreya(
                                    textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 18,
                                    color: Colors.brown,),),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15,left: 20,bottom: 20),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            addFood();
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => foodorderr()));
                                          },
                                          child: Text(
                                            "Order Now",
                                            style: GoogleFonts.alegreya(
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(Get.width * 0.1,
                                                Get.height * 0.06),
                                            primary: Colors.brown,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8)),
                                          )),
                                    ),SizedBox(width: Get.width * 0.08,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,bottom: 20,top: 15),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.alegreya(
                                                textStyle: Theme.of(context).textTheme.headline4,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(Get.width * 0.1,
                                                Get.height * 0.06),
                                            primary: Colors.brown,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8)),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );

                        }),
                  ),
                );

              }
              // snapshot.data is QuerySnapshot than I access .docs to get List<QueryDocumentSnapshot>
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}