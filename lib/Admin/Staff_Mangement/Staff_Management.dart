import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'View_StaffDetails.dart';

class StaffManage extends StatefulWidget {
  const StaffManage({super.key});

  @override
  State<StaffManage> createState() => _StaffManageState();
}

class _StaffManageState extends State<StaffManage> {
  final CollectionReference profile =
      FirebaseFirestore.instance.collection('staff');
  TextEditingController staffname = TextEditingController();
  TextEditingController staffgender = TextEditingController();
  TextEditingController staffdob = TextEditingController();
  TextEditingController staffphone = TextEditingController();
  TextEditingController staffemail = TextEditingController();
  TextEditingController staffplace = TextEditingController();
  TextEditingController staffjot = TextEditingController();
  TextEditingController staffdoj = TextEditingController();
  TextEditingController staffexp = TextEditingController();

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
              child: Stack(children: [
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 30),
                              child: Row(
                                children: [
                                  Text(
                                    "Name :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.165,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffname,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Gender :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.145,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffgender,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Date Of birth :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffdob,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Phone :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.155,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffphone,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Email :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.165,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffemail,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Place :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.175,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffplace,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Job Type :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.105,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffjot,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "DOJ :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.185,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffdoj,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Experience :",
                                    style: GoogleFonts.alegreya(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 20,
                                      color: Colors.brown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.04,
                                  ),
                                  Container(
                                    height: 50,
                                    width: Get.width * 0.52,
                                    child: TextFormField(
                                      controller: staffexp,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 40, top: 25),
                              child: ElevatedButton(
                                  onPressed: _uploadImage,
                                  child: Text(
                                    "Add Staff Details",
                                    style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        Get.width * 0.7, Get.height * 0.06),
                                    primary: Colors.brown,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 40, top: 10, bottom: 20),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewStaffProfile()));
                                  },
                                  child: Text(
                                    "View Staff Details",
                                    style: GoogleFonts.alegreya(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        Get.width * 0.7, Get.height * 0.06),
                                    primary: Colors.brown,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ))
              ]),
            )));
  }

  Future<void> _uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      String fileName = file.path.split('/').last;
      Reference ref = storage.ref().child('staff_images/$fileName');
      UploadTask task = ref.putFile(file);

      task.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();

        final staffs = {
          'name': staffname.text,
          'gender': staffgender.text,
          'dateofbirth': staffdob.text,
          'phone': staffphone.text,
          'mail': staffemail.text,
          'place': staffplace.text,
          'jobtype': staffjot.text,
          'dateofjoining': staffdoj.text,
          'experience': staffexp.text,
          'imageUrl': imageUrl,
        };

        await firestore.collection('staff').add(staffs);
        staffname.clear();
        staffgender.clear();
        staffdob.clear();
        staffphone.clear();
        staffemail.clear();
        staffplace.clear();
        staffdoj.clear();
        staffexp.clear();
      });
    }
  }
}
