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
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

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
      home: foodfingers(),
    );
  }
}
class foodfingers extends StatefulWidget {
  @override
  State<foodfingers> createState() => _foodfingersState();
}

class _foodfingersState extends State<foodfingers> {

  final CollectionReference menu = FirebaseFirestore.instance.collection('food fingers');
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
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
        fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
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
                  padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.61
                        ),
                        itemCount: snapshot.data!.docs.length ,
                        itemBuilder: (context,index){
                          final DocumentSnapshot foodsnap =snapshot.data!.docs[index];
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
                                  padding: const EdgeInsets.only(right: 25,left: 10),
                                  child: Text(foodsnap['name'],style: GoogleFonts.alegreya(
                                    textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 20,
                                    color: Colors.brown,),),
                                ), Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4,left: 15),
                                        child: Text('\$',style: TextStyle(fontSize: 16,color: Colors.brown),),
                                      ),
                                      Text(foodsnap['price'],style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(''),
                              ],
                            ),
                          );

                        }),
                  ),
                );

              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}