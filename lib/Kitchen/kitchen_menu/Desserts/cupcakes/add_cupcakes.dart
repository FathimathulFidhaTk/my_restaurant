import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/cupcakes/view_cupcake.dart';




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
      home:  AddCupcake(),
    );
  }
}



class AddCupcake extends StatefulWidget {
  AddCupcake({super.key});

  @override
  State<AddCupcake> createState() => _AddCupcakeState();
}

class _AddCupcakeState extends State<AddCupcake> {


  final TextEditingController _foodIdController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();


  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
                key: formkey,
                child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 280),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                            color: Colors.brown,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  blurRadius: 20,
                                  color: Colors.brown.withOpacity(1))
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          left: 20,
                          right: 15,
                          top: 20,
                          bottom: 20,
                          child: Container(
                              height: 720,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(10, 10),
                                        blurRadius: 20,
                                        color: Colors.brown.withOpacity(1))
                                  ]),
                              child:
                              SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 120),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.brown)
                                            ),
                                            child: TextField(
                                              controller: _foodIdController,
                                              keyboardType: TextInputType.multiline,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: BorderSide(color: Colors.brown),
                                                ),
                                                hintText: "Enter Food Id",
                                                hintStyle: GoogleFonts.alegreya(
                                                  textStyle: Theme.of(context).textTheme.headline4,
                                                  fontSize: 20,
                                                  color: Colors.brown,),
                                              ),
                                              textInputAction: TextInputAction.next,
                                            ),
                                          ),
                                        ) , Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.brown)
                                            ),
                                            child: TextField(
                                              controller: _foodNameController,
                                              keyboardType: TextInputType.multiline,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: BorderSide(color: Colors.brown),
                                                ),
                                                hintText: "Enter Food Name",
                                                hintStyle: GoogleFonts.alegreya(
                                                  textStyle: Theme.of(context).textTheme.headline4,
                                                  fontSize: 20,
                                                  color: Colors.brown,),
                                              ),
                                              textInputAction: TextInputAction.next,
                                            ),
                                          ),
                                        ) ,
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.brown)
                                            ),
                                            child: TextField(
                                              controller: _foodPriceController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: BorderSide(width: 10, color: Colors.brown),
                                                ),
                                                hintText: "Enter Price",
                                                hintStyle: GoogleFonts.alegreya(
                                                  textStyle: Theme.of(context).textTheme.headline4,
                                                  fontSize: 20,
                                                  color: Colors.brown,),
                                              ),
                                              textInputAction: TextInputAction.next,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.brown)
                                            ),
                                            child: Center(
                                              child: TextField(
                                                controller: _foodDescriptionController,
                                                keyboardType: TextInputType.multiline,
                                                maxLines: 4,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    borderSide: BorderSide(width: 10, color: Colors.brown),
                                                  ),
                                                  hintText: "Enter Description",
                                                  hintStyle:  GoogleFonts.alegreya(
                                                    textStyle: Theme.of(context).textTheme.headline4,
                                                    fontSize: 20,
                                                    color: Colors.brown,),
                                                ),
                                                textInputAction: TextInputAction.next,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 50,right: 40,top: 25),
                                          child: ElevatedButton(
                                              onPressed: _uploadImage,
                                              child: Text(
                                                "Add Food Details",
                                                style: GoogleFonts.alegreya(
                                                    textStyle: Theme.of(context).textTheme.headline4,
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(Get.width * 0.7,
                                                    Get.height * 0.06),
                                                primary: Colors.brown,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8)),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 50,right: 40,bottom: 20,top: 8),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCupcake()));
                                              },
                                              child: Text(
                                                "View Food Details",
                                                style: GoogleFonts.alegreya(
                                                    textStyle: Theme.of(context).textTheme.headline4,
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(Get.width * 0.7, Get.height * 0.06),
                                                primary: Colors.brown,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8)),
                                              )),
                                        ),
                                      ]
                                  )
                              )
                          )
                      )
                    ]
                )
            )));
  }

  Future<void> _uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      String fileName = file.path.split('/').last;
      Reference ref = storage.ref().child('cupcakefood_images/$fileName');
      UploadTask task = ref.putFile(file);

      task.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();

        final fooditemm = {
          'food id': _foodIdController.text,
          'food name': _foodNameController.text,
          'food price': _foodPriceController.text,
          'food description': _foodDescriptionController.text,
          'imageUrl': imageUrl,

        };

        await firestore.collection('cupcake').add(fooditemm);

        _foodIdController.clear();
        _foodNameController.clear();
        _foodPriceController.clear();
        _foodDescriptionController.clear();

      });
    }
  }


}
