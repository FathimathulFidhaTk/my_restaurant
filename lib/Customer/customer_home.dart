import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'HomeScreen.dart';
import 'bottomnavigator.dart';


final List<String> imglist = [
  'assets/cust_home/waffles.jpeg',
  'assets/cust_home/chocoloate.jpeg',
  'assets/cust_home/frenchtoast.jpeg',
  'assets/cust_home/passion.jpeg',
];

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home:  liquidw(),
    );
  }
}

class liquidw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
          enableSideReveal: false,
          enableLoop: false,
          disableUserGesture: false,
          ignoreUserGestureWhileAnimating: true,
          positionSlideIcon: .9,
          preferDragFromRevealedArea: true,
          pages: [
            Container(
              color: Colors.white,
              child:
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 10,top: 40),
                    child: Row(
                      children: [
                        Text("Restaurant", style: GoogleFonts.imFellDoublePica(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 35,
                          color: Colors.brown,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 10,top: 10),
                    child: Text("Let's Explore the Tasty world..!!!",
                        style: GoogleFonts.imFellDoublePica(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 25,
                          color: Colors.brown,
                        )),
                  ), Padding(
                    padding: const EdgeInsets.only(left: 30,right: 10,top: 10),
                    child: Text("Swipe to View Our Menu",
                        style: GoogleFonts.alegreya(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.brown,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 0.8,
                            animateToClosest: false,

                          ),
                          items: imglist
                              .map((item) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.brown),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10,10),
                                    blurRadius: 20,
                                    color: Colors.brown.withOpacity(0.9)
                                )
                              ],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(item,),
                              ),
                            ),
                          ))
                              .toList(),
                        )),
                  ),
                ],
              ),),
            Container(child: BottomNavigationBarExample(),)
          ]),
    );
  }
}
