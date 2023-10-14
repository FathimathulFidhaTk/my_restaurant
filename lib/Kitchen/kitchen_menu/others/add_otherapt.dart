import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/others/view_otherappt.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/salads/view_salad.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/stuffedfoods/view_stuffedfoods.dart';
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
      home:  AddOthers(),
    );
  }
}

class AddOthers extends StatefulWidget {
  AddOthers({super.key});

  @override
  State<AddOthers> createState() => _AddOthersState();
}

class _AddOthersState extends State<AddOthers> {
  final CollectionReference sp = FirebaseFirestore.instance.collection('others');
  TextEditingController spname = TextEditingController();
  TextEditingController spprice = TextEditingController();
  TextEditingController spdescription = TextEditingController();

  void soupFd(){
    final data = {

      'name':spname.text,
      'price':spprice.text,
      'description':spdescription.text,
    };

    sp.add(data);
  }


  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

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
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: FutureBuilder(
                                              future: _loadImages(),
                                              builder: (context,  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                                                return Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 30),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            image: DecorationImage(
                                                                image: NetworkImage("https://i.pinimg.com/564x/0a/d6/60/0ad66014d4cb55abee8653a2adb6f65d.jpg"),
                                                                fit: BoxFit.cover
                                                            ),
                                                            border: Border.all(color: Colors.brown)
                                                        ),
                                                        height: Get.height * 0.5,
                                                        width: Get.width * 0.8,
                                                        child: ListView.builder(
                                                          physics: NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: snapshot.data?.length,
                                                          itemBuilder: (context, index) {
                                                            final Map<String, dynamic> image = snapshot.data![index];
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(image['url'])
                                                                  )
                                                              ),

                                                              height: Get.height * 0.5,
                                                              width: Get.width * 0.8,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(child: Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(100),
                                                      ),
                                                      color: Colors.brown,
                                                      child: IconButton(
                                                        onPressed: (){
                                                          showModalBottomSheet(context: context, builder: ((builder) => bottomSheet(context)));
                                                        },icon: Center(child: Icon(Icons.add_a_photo,size: 28,color: Colors.white,)),
                                                      ),
                                                    ),
                                                      bottom: 5,
                                                      right: 10,
                                                    )
                                                  ],
                                                );
                                              }
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: Colors.brown)
                                            ),
                                            child: TextField(
                                              controller: spname,
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
                                              controller: spprice,
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
                                                controller: spdescription,
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
                                          padding: const EdgeInsets.only(left: 50,right: 40,top: 25,),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                soupFd();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddOthers()));
                                              },
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
                                          padding: const EdgeInsets.only(left: 50,right: 40,bottom: 20,top: 10),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOthers()));
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
                                        )
                                      ]
                                  )
                              )
                          )
                      )
                    ]
                )
            )));
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: 300,
      margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
      ),
      child: Column(
        children: [
          Text("Choose Profile Photo",
            style: GoogleFonts.alegreya(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 26,
              color: Colors.brown,),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera, color: Colors.brown, size: 26,),
                onPressed: () => _upload('camera'),
                label: Text("Camera",
                  style: GoogleFonts.alegreya(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 22,
                    color: Colors.brown,),
                ),), SizedBox(width: 35,),
              TextButton.icon(
                icon: Icon(Icons.image, color: Colors.brown, size: 26,),
                onPressed: () => _upload('gallery'),
                label: Text("Gallery",
                    style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown)),
              )
            ],
          )
        ],
      ),
    );
  }
}

