import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Customer/appt/foodfingers/view_more.dart';
import 'package:my_restaurant/Customer/appt/other/view_more.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize a new Firebase App instance
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home:  ViewOtherFood(),
    );
  }
}



class ViewOtherFood extends StatefulWidget {
  @override
  State<ViewOtherFood> createState() => _ViewOtherFoodState();
}

class _ViewOtherFoodState extends State<ViewOtherFood> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('others').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final foodDocs = snapshot.data!.docs;
            return Container(
              color: Colors.white,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.49
                ),
                itemCount: foodDocs.length,
                itemBuilder: (context, index) {
                  final food = foodDocs[index].data();
                  final foodDocumentId = foodDocs[index].id;
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherFoodPage(
                                  food['food name'] ?? 'No Food Name',
                                  food['food description'] ?? 'No Food description',
                                  foodDocumentId,
                                  food['imageUrl'] ?? 'URL_TO_FALLBACK_IMAGE'
                              )
                          ),
                        );
                      },
                      child: FoodCard(food: food as Map<String, dynamic>));
                },
              ),
            );


          },
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Map<String, dynamic>? food;

  FoodCard({required this.food});

  @override
  Widget build(BuildContext context) {
    final imageUrl = food?['imageUrl'] ?? 'URL_TO_FALLBACK_IMAGE';
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(
                imageUrl),
          ),
          ListTile(
            title: Text( '${food?['food name'] ?? 'No Food Name'}',style: GoogleFonts.alegreya(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                color: Colors.brown)),
            subtitle: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('\$',style: TextStyle(fontSize: 16,color: Colors.brown),),
                ),
                Text( '${food?['food price'] ?? 'No Food Price'}',style: GoogleFonts.alegreya(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 22,
                    color: Colors.brown)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
