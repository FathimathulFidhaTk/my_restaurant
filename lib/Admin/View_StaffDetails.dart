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
      home: ViewProfile(),
    );
  }
}
class ViewProfile extends StatefulWidget {
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final CollectionReference login = FirebaseFirestore.instance.collection('staff');
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
    return Scaffold(
      body:StreamBuilder(
          stream: login.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context,index){
                  final DocumentSnapshot staffsnap=snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                    child: Container(
                      height: Get.height * 0.75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.brown),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(10,10),
                              blurRadius: 20,
                              color: Colors.transparent.withOpacity(1),)
                          ]
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: FutureBuilder(
                                      future: _loadImages(),
                                      builder: (context,  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: CircleAvatar(
                                            radius: 80.0,
                                            backgroundImage: NetworkImage('https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI='),
                                            child: ListView.builder(
                                          itemCount: snapshot.data?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              final Map<String, dynamic> image = snapshot.data![index];
                                              return CircleAvatar(
                                                radius: 80.0,
                                                backgroundImage: NetworkImage(image['url']),
                                              );
                                            },
                                          ),

                                          ),
                                        );
                                      }
                                  ),
                                ),
                                Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 90,top: 15),
                                        child: Text("Name :",style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15,top: 15),
                                        child: Text(staffsnap['name'],style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      ),]),
                                Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 80,top: 15),
                                        child: Text("Gender :",style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15,top: 15),
                                        child: Text(staffsnap['gender'],style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      ),]),
                                Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 35,top: 10),
                                        child: Text("Date of Birth :",style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10,left: 15),
                                        child: Text(staffsnap['dateofbirth'],style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      ),
                                    ]),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 88,top: 10),
                                      child: Text("Phone :",style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 10),
                                      child: Text(staffsnap['phone'],style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 95,top: 10),
                                      child: Text("Email :",style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 20,
                                        color: Colors.brown,),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 10),
                                      child: Text(staffsnap['mail'],style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 95,top: 10),
                                      child: Text("Place :",style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 10),
                                      child: Text(staffsnap['place'],style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 70,top: 10),
                                      child: Text("Job Type :",style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 10),
                                      child: Text(staffsnap['jobtype'],style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 10),
                                      child: Text("Date of Joining :",style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,top: 10),
                                      child: Text(staffsnap['dateofjoining'],style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context).textTheme.headline4,
                                        fontSize: 22,
                                        color: Colors.brown,),),
                                    ),
                                  ],
                                ),
                                Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 45,top: 10),
                                        child: Text("Experience :",style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15,top: 10),
                                        child: Text(staffsnap['experience'],style: GoogleFonts.alegreya(
                                          textStyle: Theme.of(context).textTheme.headline4,
                                          fontSize: 22,
                                          color: Colors.brown,),),
                                      )])
                              ],
                            )
                        ),

                      ),
                    ),
                  );
                },itemCount:snapshot.data!.docs.length ,);
            }
            return Container();
          }),
    );
  }
}