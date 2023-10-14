import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

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
      home:  PreparedOrders(),
    );
  }
}


class PreparedOrders extends StatefulWidget {

  @override
  State<PreparedOrders> createState() => _PreparedOrdersState();
}

class _PreparedOrdersState extends State<PreparedOrders> {
  final CollectionReference orderfd = FirebaseFirestore.instance.collection('prepared orders');
  TextEditingController order = TextEditingController();

  void orders(){
    final data = {
      'food order': order.text
    };
    orderfd.add(data);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:60 ,left: 15,right: 15),
            child: Container(
              height: Get.height * 0.75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.brown),
                  color: Colors.brown,
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
                          padding: const EdgeInsets.only(left: 10,top: 110),
                          child: Row(
                            children: [
                              SizedBox(width: Get.width * 0.13,),
                              Container(
                                  height: 200,
                                  width: Get.width * 0.6,
                                  child:  TextField(
                                    controller: order,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 10,
                                  )
                              )
                            ],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50,right: 40,top: 30),
                          child: ElevatedButton(
                              onPressed: () {
                                orders();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PreparedOrders()));
                              },
                              child: Text(
                                "Send",
                                style: GoogleFonts.alegreya(
                                    textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(Get.width * 0.7,
                                    Get.height * 0.08),
                                primary: Colors.brown,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              )),
                        ),
                      ],
                    )
                ),

              ),
            ),
          ),
        )

    ));
  }
}