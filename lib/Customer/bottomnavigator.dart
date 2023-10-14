import 'package:flutter/material.dart';
import 'package:my_restaurant/Customer/HomeScreen.dart';
import 'package:my_restaurant/Customer/feedback.dart';
import 'package:my_restaurant/Intro_Pages/screenpage.dart';
import 'package:path/path.dart';



void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Home(),
    FeedbackMessage(),
    ScreenPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 55,
        color: Colors.grey[700],
        child: BottomNavigationBar(
          unselectedItemColor: Colors.brown,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: Colors.grey),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,size: 25,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_rounded,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.feedback_outlined,
                ),
                label: "Feedback"
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.login_outlined,
                ),
                label: 'Logout'),

          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

        ),
      ),
    );
  }
}
