import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


class ViewSmoothie extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FoodList(),
      ),
    );
  }
}

class FoodList extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('smoothie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final foodItems = snapshot.data!.docs;
        return Padding(
          padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Container(
            height: Get.height * 5,
            child: GridView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final foodItem = foodItems[index];
                return FoodItemCard(foodItem: foodItem);
              }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 8,
                childAspectRatio: 0.47
            ),
            ),
          ),
        );

      },
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final QueryDocumentSnapshot foodItem;

  FoodItemCard({required this.foodItem});

  Future<void> _deleteItem() async {
    await foodItem.reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = foodItem?['imageUrl'] ?? 'URL_TO_FALLBACK_IMAGE';
    return Container(
        height: Get.height * 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: Colors.brown),
            boxShadow: [
              BoxShadow(
                  offset: Offset(10,10),
                  blurRadius: 20,
                  color: Colors.transparent.withOpacity(1)

              )
            ]
        ),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                    imageUrl),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6,left: 8),
                child: Text(
                  '${foodItem?['food name'] ?? 'No Food Name'}',
                  style: GoogleFonts.alegreya(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 21.5, color: Colors.brown,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Text('\$',
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22, color: Colors.brown,),),
                    Padding(
                      padding: const EdgeInsets.only(left: 4,),
                      child: Text('${foodItem?['food price'] ?? 'No Food Price'}',
                        style: GoogleFonts.alegreya(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 24, color: Colors.brown,),),
                    ),SizedBox(width: 50,),(
                        IconButton(
                            onPressed: _deleteItem,
                            icon: Icon(Icons.delete_forever,color: Colors.brown,)))
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
