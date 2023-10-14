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
      home:  FeedbackMessage(),
    );
  }
}


class FeedbackMessage extends StatefulWidget {

  @override
  State<FeedbackMessage> createState() => _FeedbackMessageState();
}

class _FeedbackMessageState extends State<FeedbackMessage> {
  final CollectionReference message = FirebaseFirestore.instance.collection('FeedBack');
   TextEditingController msg = TextEditingController();

   void feedBack(){
     final data = {
       'feedback': msg.text
     };
     message.add(data);

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
                                         Text("FeedBack :",style: GoogleFonts.alegreya(
                                           textStyle: Theme.of(context).textTheme.headline4,
                                           fontSize: 20,
                                           color: Colors.brown,),),
                                         SizedBox(width: Get.width * 0.02,),
                                         Container(
                                           height: 200,
                                           width: Get.width * 0.6,
                                           child:  TextField(
                                             controller: msg,
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
                                           feedBack();
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackMessage()));
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