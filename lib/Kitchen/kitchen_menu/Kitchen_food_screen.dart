import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/parathas/add_parathas.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/vegg/add_veg.dart';
import 'Beverages/Beverages.dart';
import 'Burger/add_burgers.dart';
import 'Non - vegg/non_veg.dart';
import 'Pasta/add_pasta.dart';
import 'Piza/add_pizza.dart';
import 'Sandwich/add_sandwich.dart';
import 'appetizers.dart';
import 'arabian/add_arabian.dart';
import 'breakfast.dart';
import 'desserts.dart';

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
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: KitchenMenu(),
    );
  }
}

class KitchenMenu extends StatefulWidget {
  @override
  State<KitchenMenu> createState() => _KitchenMenuState();
}

class _KitchenMenuState extends State<KitchenMenu> {
  var img = [
    "assets/kitchen/menu/appetizer.jpeg",
    "assets/kitchen/menu/b2.jpeg",
    "assets/kitchen/menu/pasta.jpeg",
    "assets/kitchen/menu/pizzza.png",
    "assets/kitchen/menu/sandwich.jpeg",
    "assets/kitchen/menu/burger.jpeg",
    "assets/kitchen/menu/deserts.jpeg",
    "assets/kitchen/menu/beverages.jpeg",
    "assets/kitchen/menu/chikhen.jpeg",
    "assets/kitchen/menu/veg.png",
    "assets/kitchen/menu/Biryani.jpeg",
    "assets/kitchen/menu/parathas.jpeg",
  ];

  var txt = [
    '\nA\nP\nP\nE\nT\nI\nZ\nE\nR',
    '\nB\nR\nE\nA\nK\nF\nA\nS\nT',
    '\n\n\nP\nA\nS\nT\nA',
    '\n\n\nP\nI\nZ\nZ\nA',
    '\nS\nA\nN\nD\nW\nI\nC\nH\nE',
    '\n\nB\nU\nR\nG\nE\nR',
    '\nD\nE\nS\nS\nE\nR\nT\nS',
    '\nB\nE\nV\nE\nR\nA\nG\nE\nS',
    '\n\nN\nO\nN\n-\nV\nE\nG',
    '\n\n\n\nV\nE\nG',
    '\n\nA\nR\nA\nB\nI\nA\nN',
    '\nP\nA\nR\nA\nT\nH\nA\nS',
  ];

  var link = [
    Appetizers(),
    BreakFast(),
    AddPasta(),
    AddPizza(),
    AddSandwich(),
    AddBurgers(),
    Desserts(),
    Beverages(),
    NonVeg(),
    AddVeg(),
    AddArabian(),
    AddParathas()
  ];

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
                    Text("Food",
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
                                  childAspectRatio: 0.65),
                          itemCount: img.length,
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
                                                        .withOpacity(1))
                                              ],
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    img[index],
                                                  ),
                                                  fit: BoxFit.cover)),
                                          child: GestureDetector(onTap: () {
                                            setState(() {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      link[index],
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
                                                txt[index],
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
