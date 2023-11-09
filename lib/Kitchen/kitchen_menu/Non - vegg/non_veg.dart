import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/Cakes/add_cakes.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/Ice%20cream/add_icecream.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/Pie/add_pie.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/brownies/add_brownies.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/chocolates/add_chocolates.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/cookies/add_cookies.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/cupcakes/add_cupcakes.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/puddings/add_puddings.dart';

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
      home:  NonVeg(),
    );
  }
}

class NonVeg extends StatefulWidget{
  @override
  State<NonVeg> createState() => _NonVegState();
}

class _NonVegState extends State<NonVeg> {
  @override

  var desertType = ["assets/kitchen/menu/nonvegg/chickhen.jpeg",
    "assets/kitchen/menu/nonvegg/beef.jpeg",
    "assets/kitchen/menu/nonvegg/pork.jpeg","assets/kitchen/menu/nonvegg/lamb.jpeg",
    "assets/kitchen/menu/nonvegg/duck.jpeg","assets/kitchen/menu/nonvegg/fish.jpeg",];

  var text3 =["\n\nC\nH\nI\nC\nK\nH\nE\nN","\n\n\n\n\nB\nE\nE\nF","\n\n\n\n\nP\nO\nR\nK","\n\n\n\n\nL\nA\nM\nB",
    '\n\n\n\n\nD\nU\nC\nK','\n\n\n\n\nF\nI\nS\nH'];

  var link =[AddCake(),AddPie(),AddIcecream(),AddCookies(),AddBrownies(),AddCupcake(), AddPuddings(),AddChocolate()];
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
                    SizedBox(height: 15,),
                    Text("Beverages",
                        style: GoogleFonts.alegreya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 28.5,
                            color: Colors.brown)),
                    Text("Categories",
                        style: GoogleFonts.alegreya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 30,
                            color: Colors.brown)),
                    Text("-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --",
                      style: TextStyle(color: Colors.brown),),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              childAspectRatio: 0.565
                          ),
                          itemCount: desertType.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                                                bottomRight: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  // offset: Offset(10, 10),
                                                  // blurRadius: 20,
                                                    color: Colors.transparent.withOpacity(0.9))
                                              ],
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    desertType[index],
                                                  ),
                                                  fit: BoxFit.cover)),
                                          child: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) => link[index],
                                                    ),
                                                  );
                                                });
                                              }
                                          ),
                                        )
                                    ),
                                    Flexible(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                text3[index],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.alegreya(
                                                    textStyle:
                                                    Theme.of(context).textTheme.headline4,
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
            )
        ),
      ),
    );
  }
}
