import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/Cakes/view_cakes.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/Ice%20cream/view_icecream.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/Pie/view_pie.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/brownies/view_brownies.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/chocolates/view_chocolates.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/cookies/view_cookies.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/cupcakes/view_cupcake.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/Desserts/puddings/view_puddings.dart';

void main() {
  runApp(MaterialApp(
    home: AdminDesserts(),
    debugShowCheckedModeBanner: false,
  ));
}

class AdminDesserts extends StatefulWidget{
  @override
  State<AdminDesserts> createState() => _AdminDessertsState();
}

class _AdminDessertsState extends State<AdminDesserts> {
  @override

  var desertType = ["assets/kitchen/menu/deserts/cakes.jpeg","assets/kitchen/menu/deserts/pie.jpeg",
    "assets/kitchen/menu/deserts/icecream.png","assets/kitchen/menu/deserts/cookie.png","assets/kitchen/menu/deserts/browni.jpeg",
    "assets/kitchen/menu/deserts/cupcakes.jpeg", "assets/kitchen/menu/deserts/pudding.jpeg" ,"assets/kitchen/menu/deserts/chocolates.jpeg"];

  var text3 =["\n\n\n\nC\nA\nK\nE\nS","\n\n\n\n\nP\nI\nE","\n\nI\nC\nE\nC\nR\nE\nA\nM","\n\nC\nO\nO\nK\nI\nE\nS",
    '\n\nB\nR\nO\nW\nN\nI\nE\nS','\n\nC\nU\nP\nC\nA\nK\nE\nS','\n\nP\nU\nD\nD\nI\nN\nG','\nC\nH\nO\nC\nO\nL\nO\nA\nT\nE\nS'];

  var link =[ViewCakes(),ViewPie(),ViewIcecream(),ViewCookies(),ViewBrownies(),ViewCupcake(),ViewPudding(),ViewChocolate()];
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
                    Text("Desserts",
                        style: GoogleFonts.alegreya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 30,
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
