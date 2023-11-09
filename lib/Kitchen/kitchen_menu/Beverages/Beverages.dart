import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Beverages/cocktail/add_cocktail.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Beverages/coffee/add_coffe.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Beverages/juice/add_juice.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Beverages/milkshakes/add_milkshakes.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Beverages/smoothie/add_smoothie.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Beverages/tea/add_tea.dart';

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
      home:  Beverages(),
    );
  }
}
class Beverages extends StatefulWidget{
  @override
  State<Beverages> createState() => _BeveragesState();
}

class _BeveragesState extends State<Beverages> {
  @override

  var desertType = ["assets/kitchen/menu/beverages/coffee.jpeg","assets/kitchen/menu/beverages/juice.jpeg",
    "assets/kitchen/menu/beverages/smoothie.jpeg","assets/kitchen/menu/beverages/tea.jpeg","assets/kitchen/menu/beverages/cocktails.jpeg","assets/kitchen/menu/beverages/Milkshakes.jpeg",];

  var text3 =["\n\n\nC\nO\nF\nF\nE\nE\n","\n\n\n\nJ\nU\nI\nC\nE\n","\n\nS\nM\nO\nO\nT\nH\nI\nE","\n\n\n\n\nT\nE\nA\n",
    '\n\nC\nO\nC\nK\nT\nA\nI\nL','\n\nM\nI\nL\nK\nS\nH\nA\nK\nE\nS'];

  var link =[AddCoffee(),AddJuice(),AddSmoothie(),AddTea(),AddCocktail(),AddMilkshakes()];
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
