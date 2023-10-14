import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Customer/appt/dip/view%20more.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: FoodListPage(),
  ));
}

class FoodListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewFoodPage(),
    );
  }
}

class ViewFoodPage extends StatefulWidget {
  @override
  State<ViewFoodPage> createState() => _ViewFoodPageState();
}

class _ViewFoodPageState extends State<ViewFoodPage> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('food menu').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final foodDocs = snapshot.data!.docs;
            return Container(

              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 0.48
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
                            builder: (context) => FoodDetailsPage(
                                food['food name'] ?? 'No Food Name',
                                food['food description'] ?? 'No Food description',
                              foodDocumentId,
                                food['imageUrl'] ?? 'URL_TO_FALLBACK_IMAGE',
                                food['food price'] ?? 'URL_TO_FALLBACK_IMAGE'
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
