import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Admin/Staff_Mangement/Staff_Management.dart';
import 'kitchen_home.dart';

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
      home:  MyAppp(),
    );
  }
}
class MyAppp extends StatefulWidget {
  const MyAppp({Key? key}) : super(key: key);

  @override
  MyApppState createState() => MyApppState();
}
class MyApppState extends State<MyAppp> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
  GlobalKey<SliderDrawerState>();

  List drawerr= [kitchenHome(),StaffManage(),kitchenHome(),kitchenHome(),kitchenHome(),kitchenHome(),kitchenHome(),kitchenHome(),];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: SliderDrawer(
                appBar: SliderAppBar(
                    appBarColor: Colors.white,
                  title: Text(""),
                ),
                key: _sliderDrawerKey,
                sliderOpenSize: 250,
                slider: _SliderView(
                  onItemClick: (title) {
                    _sliderDrawerKey.currentState!.closeSlider();
                    setState(() {
                    });
                  },
                ), child: kitchenHome()),
          ),
        ),
      ),
    );
  }
}
class _SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(60),bottomRight: Radius.circular(25)),
        color: Colors.brown,
      ),
      child: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(25),),
              image: DecorationImage(
                  image: AssetImage("assets/kitchen/cheif.jpeg"),fit: BoxFit.cover
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(10, 10),
                    blurRadius: 20,
                    color: Colors.brown.withOpacity(1.0))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...[
            Menu(Icons.home, 'Home'),
            Menu(Icons.person, 'Profile'),
            Menu(Icons.restaurant_menu, 'Add Menu'),
            Menu(Icons.menu_book_sharp, 'View Menu'),
            Menu(Icons.library_books_sharp, 'View Orders'),
            Menu(Icons.send, 'Prepared Orders'),
            Menu(Icons.feedback, 'FeedBacks'),
            Menu(Icons.logout_sharp, 'LogOut'),
          ]
              .map((menu) => _SliderMenuItem(
              title: menu.title,
              iconData: menu.iconData,
              onTap: onItemClick))
              .toList(),
        ],
      ),
    );
  }
}
class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _SliderMenuItem(
      {Key? key,
        required this.title,
        required this.iconData,
        required this.onTap})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(title,
              style: GoogleFonts.alegreya(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 20,
                color: Colors.white,
              )),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Icon(iconData, color: Colors.white),
        ),
        onTap: () => onTap?.call(title));
  }
}

class Menu {
  final IconData iconData;
  final String title;

  Menu(this.iconData, this.title);
}
