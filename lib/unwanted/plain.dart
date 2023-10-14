import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Ordering App')),
      body: FoodOrdersScreen(user: user),
    );
  }
}

class FoodItem {
  final String name;
  final double price;

  FoodItem({required this.name, required this.price});
}

class FoodOrdersScreen extends StatefulWidget {
  final User user;

  FoodOrdersScreen({required this.user});

  @override
  _FoodOrdersScreenState createState() => _FoodOrdersScreenState();
}

class _FoodOrdersScreenState extends State<FoodOrdersScreen> {
  List<FoodItem> foodOrders = [];

  @override
  void initState() {
    super.initState();
    fetchFoodOrders();
  }

  Future<void> fetchFoodOrders() async {
    try {
      final userUID = widget.user.uid;

      final collection = FirebaseFirestore.instance.collection('users');
      final querySnapshot = await collection.where('user_uid', isEqualTo: userUID).get();

      List<FoodItem> orders = querySnapshot.docs.map((doc) {
        return FoodItem(name: doc['food name'], price: doc['food price'].toDouble());
      }).toList();

      setState(() {
        foodOrders = orders;
      });
    } catch (e) {
      print('Error fetching food orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: foodOrders.length,
      itemBuilder: (context, index) {
        FoodItem foodOrder = foodOrders[index];
        return ListTile(
          title: Text(foodOrder.name),
          subtitle: Text('Price: \$${foodOrder.price.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
