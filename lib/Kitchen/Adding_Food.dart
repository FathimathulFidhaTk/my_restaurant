// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Initialize a new Firebase App instance
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Remove the debug banner
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.green),
//       home:  AddFood(),
//     );
//   }
// }
//
// class AddFood extends StatefulWidget {
//
//   @override
//   State<AddFood> createState() => _AddFoodState();
// }
//
// class _AddFoodState extends State<AddFood> {
//
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;
//
//   File? _photo;
//   final ImagePicker _picker = ImagePicker();
//
//   Future imgFromGallery(String inputSource) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);
//         uploadFile();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   Future imgFromCamera(String inputSource) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//
//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);
//         uploadFile();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   Future uploadFile() async {
//     if (_photo == null) return;
//     final fileName = basename(_photo!.path);
//     final destination = 'files/$fileName';
//
//     try {
//       final ref = firebase_storage.FirebaseStorage.instance
//           .ref(destination)
//           .child('file/');
//       await ref.putFile(_photo!);
//     } catch (e) {
//       print('error occured');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 280),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(25),
//                             bottomRight: Radius.circular(25)),
//                         color: Colors.brown,
//                         boxShadow: [
//                           BoxShadow(
//                               offset: Offset(10, 10),
//                               blurRadius: 20,
//                               color: Colors.brown.withOpacity(1))
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       left: 20,
//                       right: 15,
//                       top: 20,
//                       bottom: 20,
//                       child: Container(
//                           height: 720,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                     offset: Offset(10, 10),
//                                     blurRadius: 20,
//                                     color: Colors.brown.withOpacity(1))
//                               ]),
//                           child:
//                           SingleChildScrollView(
//                               child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Stack(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 30,left: 21),
//                                             child: Container(
//                                               height: Get.height * 0.5,
//                                               width: Get.width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       // offset: Offset(10, 10),
//                                                       // blurRadius: 20,
//                                                         color: Colors.brown.withOpacity(1))
//                                                   ],
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   border: Border.all(color: Colors.brown)
//                                               ),
//                                               child: _photo != null
//                                                   ? Image.file(
//                                                 _photo!,
//                                                 height: Get.height * 0.5,
//                                                 width: Get.width * 0.8,
//                                                 fit: BoxFit.cover,
//                                               )
//                                                   : Container(
//                                                 decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(8),
//                                                     image: DecorationImage(
//                                                         image: NetworkImage("https://i.pinimg.com/564x/0a/d6/60/0ad66014d4cb55abee8653a2adb6f65d.jpg"),
//                                                         fit: BoxFit.cover
//                                                     ),
//                                                     border: Border.all(color: Colors.brown)
//                                                 ),
//                                                 height: Get.height * 0.5,
//                                                 width: Get.width * 0.8,
//                                               ),
//                                             ),),
//                                           Positioned(child: Card(
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(100),
//                                             ),
//                                             color: Colors.brown,
//                                             child: IconButton(
//                                               onPressed: (){
//                                                 showModalBottomSheet(context: context, builder: ((builder) => bottomSheet(context)));
//                                               },icon: Center(child: Icon(Icons.add_a_photo,size: 28,color: Colors.white,)),
//                                             ),
//                                           ),
//                                             bottom: 5,
//                                             right: 10,
//                                           )]
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(12),
//                                             border: Border.all(color: Colors.brown)
//                                         ),
//                                         child: TextField(
//                                           keyboardType: TextInputType.multiline,
//                                           decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(12),
//                                               borderSide: BorderSide(color: Colors.brown),
//                                             ),
//                                             hintText: "Enter Food Name",
//                                             hintStyle: GoogleFonts.alegreya(
//                                               textStyle: Theme.of(context).textTheme.headline4,
//                                               fontSize: 20,
//                                               color: Colors.brown,),
//                                           ),
//                                           textInputAction: TextInputAction.next,
//                                         ),
//                                       ),
//                                     ) ,
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(12),
//                                             border: Border.all(color: Colors.brown)
//                                         ),
//                                         child: TextField(
//                                           decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(12),
//                                               borderSide: BorderSide(width: 10, color: Colors.brown),
//                                             ),
//                                             hintText: "Enter Price",
//                                             hintStyle: GoogleFonts.alegreya(
//                                               textStyle: Theme.of(context).textTheme.headline4,
//                                               fontSize: 20,
//                                               color: Colors.brown,),
//                                           ),
//                                           textInputAction: TextInputAction.next,
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(12),
//                                             border: Border.all(color: Colors.brown)
//                                         ),
//                                         child: Center(
//                                           child: TextField(
//                                             keyboardType: TextInputType.multiline,
//                                             maxLines: 4,
//                                             decoration: InputDecoration(
//                                               border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(12),
//                                                 borderSide: BorderSide(width: 10, color: Colors.brown),
//                                               ),
//                                               hintText: "Enter Description",
//                                               hintStyle:  GoogleFonts.alegreya(
//                                                 textStyle: Theme.of(context).textTheme.headline4,
//                                                 fontSize: 20,
//                                                 color: Colors.brown,),
//                                             ),
//                                             textInputAction: TextInputAction.next,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 50,right: 40,top: 25),
//                                       child: ElevatedButton(
//                                           onPressed: () {
//                                           },
//                                           child: Text(
//                                             "Add Food Details",
//                                             style: GoogleFonts.alegreya(
//                                                 textStyle: Theme.of(context).textTheme.headline4,
//                                                 fontSize: 20,
//                                                 color: Colors.white),
//                                           ),
//                                           style: ElevatedButton.styleFrom(
//                                             minimumSize: Size(Get.width * 0.7,
//                                                 Get.height * 0.06),
//                                             primary: Colors.brown,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.circular(8)),
//                                           )),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 50,right: 40,top: 10,bottom: 20),
//                                       child: ElevatedButton(
//                                           onPressed: () {
//                                           },
//                                           child: Text(
//                                             "View Food Details",
//                                             style: GoogleFonts.alegreya(
//                                                 textStyle: Theme.of(context).textTheme.headline4,
//                                                 fontSize: 20,
//                                                 color: Colors.white),
//                                           ),
//                                           style: ElevatedButton.styleFrom(
//                                             minimumSize: Size(Get.width * 0.7, Get.height * 0.06),
//                                             primary: Colors.brown,
//                                             shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.circular(8)),
//                                           )),
//                                     )
//                                   ]
//                               )
//                           )
//                       )
//                   )
//                 ]
//             )
//         )
//     );
//   }
//   Widget bottomSheet(BuildContext context) {
//     return Container(
//       height: 100.0,
//       width: 300,
//       margin: EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 20
//       ),
//       child: Column(
//         children: [
//           Text("Choose Profile Photo",
//             style: GoogleFonts.alegreya(
//               textStyle: Theme.of(context).textTheme.headline4,
//               fontSize: 26,
//               color: Colors.brown,),),
//           SizedBox(height: 10,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton.icon(
//                 icon: Icon(Icons.camera, color: Colors.brown, size: 26,),
//                 onPressed: () => imgFromCamera('camera'),
//                 label: Text("Camera",
//                   style: GoogleFonts.alegreya(
//                     textStyle: Theme.of(context).textTheme.headline4,
//                     fontSize: 22,
//                     color: Colors.brown,),
//                 ),), SizedBox(width: 35,),
//               TextButton.icon(
//                 icon: Icon(Icons.image, color: Colors.brown, size: 26,),
//                 onPressed: () => imgFromGallery('gallery'),
//                 label: Text("Gallery",
//                     style: GoogleFonts.alegreya(
//                         textStyle: Theme.of(context).textTheme.headline4,
//                         fontSize: 22,
//                         color: Colors.brown)),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }