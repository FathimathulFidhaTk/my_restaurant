import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
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
      home: ViewFeedback(),
    );
  }
}
class ViewFeedback extends StatefulWidget {
  @override
  State<ViewFeedback> createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  final CollectionReference message = FirebaseFirestore.instance.collection('FeedBack');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
          stream: message.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context,index){
                  final DocumentSnapshot msgsnap=snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                    child: Container(
                      height: Get.height * 0.3,
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,top: 15),
                                  child: Text(msgsnap['feedback'],style: GoogleFonts.alegreya(
                                    textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 22,
                                    color: Colors.brown,),),
                                ),
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