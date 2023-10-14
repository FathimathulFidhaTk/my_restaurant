import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Admin/admin_appt/fooddfingers/view_food_fingers.dart';
import 'package:my_restaurant/Admin/admin_appt/other/view_other_appt.dart';
import 'package:my_restaurant/Admin/admin_appt/salad/view_salads.dart';
import 'package:my_restaurant/Admin/admin_appt/soup/view_soup.dart';
import 'package:my_restaurant/Admin/admin_appt/stuffedfood/view_stuffedfoods.dart';

import 'dip/view_food_details.dart';

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
      home:  AdminAppetizers(),
    );
  }
}

class AdminAppetizers extends StatefulWidget {
  @override
  State<AdminAppetizers> createState() => _AdminAppetizersState();
}

class _AdminAppetizersState extends State<AdminAppetizers> {
  @override
  var appetizersType = [
    "assets/kitchen/menu/appetizers/dip.jpeg",
    "assets/kitchen/menu/appetizers/fingerfoods.jpeg",
    "assets/kitchen/menu/appetizers/soup.jpeg",
    "assets/kitchen/menu/appetizers/salads.jpeg",
    "assets/kitchen/menu/appetizers/stuffedfoods.jpeg",
    "assets/kitchen/menu/appetizers/others.jpeg"
  ];

  var text = [
    "\n\n\n\nD\nI\nP\nS",
    "\nF\nO\nO\nD\nF\nI\nN\nG\nE\nR\nS",
    "\n\n\n\nS\nO\nU\nP",
    "\n\n\n\nS\nA\nL\nA\nD\nS",
    '\nS\nT\nU\nF\nF\nE\nD\nF\nO\nO\nD',
    '\n\n\n\nO\nT\nH\nE\nR\nS'
  ];

  var appt =[ViewDip(),ViewFoodFingers(),ViewFoodSoup(),ViewFoodSalads(),ViewStuffedFoods(),ViewOtherFoodDetails()];

  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text("Appetizers",
                        style: GoogleFonts.alegreya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 30,
                            color: Colors.brown)),
                    Text("Categories",
                        style: GoogleFonts.alegreya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 30,
                            color: Colors.brown)),
                    Text(
                      "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --",
                      style: TextStyle(color: Colors.brown),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  childAspectRatio: 0.565),
                          itemCount: appetizersType.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.brown,
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                        flex: 6,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    // offset: Offset(10, 10),
                                                    // blurRadius: 20,
                                                    color: Colors.transparent
                                                        .withOpacity(0.9))
                                              ],
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    appetizersType[index],
                                                  ),
                                                  fit: BoxFit.cover)),
                                          child: GestureDetector(onTap: () {
                                            setState(() {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      appt[index],
                                                ),
                                              );
                                            });
                                          }),
                                        )),
                                    Flexible(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                text[index],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.alegreya(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .headline4,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
