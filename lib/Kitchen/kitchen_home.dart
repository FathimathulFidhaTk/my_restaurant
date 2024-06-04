import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final List<String> imglist = [
  'assets/kitchen/home/img1.jpeg',
  'assets/kitchen/home/img2.jpeg',
  'assets/kitchen/home/img3.jpeg',
  'assets/kitchen/home/img5.jpeg',
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
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: kitchenHome(),
    );
  }
}

class kitchenHome extends StatefulWidget {
  @override
  State<kitchenHome> createState() => _kitchenHomeState();
}

class _kitchenHomeState extends State<kitchenHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 130),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                ),
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  aspectRatio: 0.9,
                  animateToClosest: false,
                ),
                items: imglist
                    .map((item) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.brown),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  blurRadius: 20,
                                  color: Colors.brown.withOpacity(0.9))
                            ],
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                item,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              )),
        ),
      ),
    );
  }
}
