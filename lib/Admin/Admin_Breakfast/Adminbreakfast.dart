import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Kitchen/kitchen_menu/BreakFast/Eggs/view_eggs.dart';
import '../../Kitchen/kitchen_menu/BreakFast/Croissants/view_croissants.dart';
import '../../Kitchen/kitchen_menu/BreakFast/Tost/view_toast.dart';
import '../../Kitchen/kitchen_menu/BreakFast/cerals/view_cerals.dart';
import '../../Kitchen/kitchen_menu/BreakFast/pancakes/view_pancakes.dart';
import '../../Kitchen/kitchen_menu/BreakFast/waffles/view_waffles.dart';

class AdminBreakFast extends StatefulWidget {
  @override
  State<AdminBreakFast> createState() => _AdminBreakFastState();
}

class _AdminBreakFastState extends State<AdminBreakFast> {
  @override
  var breakfastType = [
    "assets/kitchen/menu/breakfast/cerals.jpeg",
    "assets/kitchen/menu/breakfast/toast.jpeg",
    "assets/kitchen/menu/breakfast/Eggs.jpeg",
    "assets/kitchen/menu/breakfast/pancake.jpeg",
    "assets/kitchen/menu/breakfast/waffles.jpeg",
    "assets/kitchen/menu/breakfast/Crossiant.jpeg"
  ];

  var text2 = [
    "\n\n\nC\nE\nR\nA\nL\nS",
    "\n\n\n\nT\nO\nS\nT",
    "\n\n\n\nE\nG\nG\nS",
    "\n\nP\nA\nN\nC\nA\nK\nE\nS",
    '\n\nW\nA\nF\nF\nL\nE\nS',
    '\nC\nR\nO\nI\nS\nS\nA\nN\nT\nS'
  ];

  var link = [
    ViewCerals(),
    ViewToast(),
    ViewEggs(),
    ViewPacakes(),
    ViewWaffles(),
    ViewCroissants()
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
                    Text("BreakFast",
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
                          itemCount: breakfastType.length,
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
                                                    breakfastType[index],
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
                                                text2[index],
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
