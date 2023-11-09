import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OrderList(),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('food orders').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final orders = snapshot.data!.docs;

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(order: order);
          },
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final QueryDocumentSnapshot order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final image = order['imageUrl'];
    final foodName = order['food Name'];
    final foodPrice = order['food Price'];
    final foodqty = order['Quantity'];
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.7,
                width: Get.width * 0.92,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    offset: Offset(10, 10),
                    blurRadius: 20,
                    color: Colors.transparent.withOpacity(1),
                  )
                ], borderRadius: BorderRadius.circular(8)),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: Get.height * 0.51,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Text('$foodName',
                            style: GoogleFonts.alegreya(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 24,
                                color: Colors.brown)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Text('\$${foodPrice}',
                            style: GoogleFonts.alegreya(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 24,
                                color: Colors.brown)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text('qty: $foodqty',
                            style: GoogleFonts.alegreya(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 20,
                                color: Colors.brown)),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
