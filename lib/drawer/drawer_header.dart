import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 340,
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
      ],
    );
  }
}