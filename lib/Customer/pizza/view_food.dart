import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Customer/pizza/view_more.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';


class ViewCustPizza extends StatefulWidget {
  @override
  State<ViewCustPizza> createState() => _ViewCustPizzaState();
}

class _ViewCustPizzaState extends State<ViewCustPizza> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pizza').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final foodDocs = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  width: screenWidth,
                  height: screenHeight,
                  child:
                  StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    itemBuilder: (context, index) {
                      final food = foodDocs[index].data();
                      final foodDocumentId = foodDocs[index].id;
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PizzaPage(
                                      food['food name'] ?? 'No Food Name',
                                      food['food description'] ??
                                          'No Food description',
                                      foodDocumentId,
                                      food['imageUrl'] ?? 'URL_TO_FALLBACK_IMAGE',
                                      food['food price'] ??
                                          'URL_TO_FALLBACK_IMAGE')),
                            );
                          },
                          child: FoodCard(food: food as Map<String, dynamic>));
                    },
                    itemCount: foodDocs.length,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  )),
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
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.brown),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                offset: Offset(10, 10),
                blurRadius: 20,
                color: Colors.transparent.withOpacity(1))
          ]),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Text('${food?['food name'] ?? 'No Food Name'}',
                  style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 24,
                      color: Colors.brown)),
            ),
            Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6,left: 15,bottom: 15),
                    child: Text(
                      '\$',
                      style: TextStyle(fontSize: 16, color: Colors.brown),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text('${food?['food price'] ?? 'No Food Price'}',
                        style: GoogleFonts.alegreya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 22,
                            color: Colors.brown)),
                  ),
                ])
          ]
      ),
    );
  }
}
