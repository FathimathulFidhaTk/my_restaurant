import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class Updateuser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Updateuser_state();
}

class Updateuser_state extends State<Updateuser> {
  final CollectionReference login=FirebaseFirestore.instance.collection('food menu');
  TextEditingController foodsnapname=TextEditingController();
  TextEditingController foodsnapprice =TextEditingController();
  void updateuser(docid){
    final data={'name':foodsnapname.text,
      'price':foodsnapprice.text};
    login.doc(docid).update(data).then((value) => Navigator.pop(context));
  }

  @override
  GlobalKey<FormState> formkey=GlobalKey();
  bool showpass=true;
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as Map;
    foodsnapname.text=args['name'];
    foodsnapprice.text=args['price'];
    final docid=args['id'];
    return Scaffold(
        appBar: AppBar(
          title: Text("",style: TextStyle(fontSize: 30),),
        ),

        body:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: foodsnapname,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText:"Donar Name",)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(controller: foodsnapprice,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText:"Phone nomber",)),
              ),
              ElevatedButton(onPressed: (){
                updateuser(docid);
              }, child: Text("Update"),style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(150,50)),backgroundColor: MaterialStateProperty.all(Colors.red))

              )])
    );
  }
}