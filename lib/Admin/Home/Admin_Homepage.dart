import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/Admin/Home/admin_tile.dart';
import 'package:my_restaurant/Admin/viewfoodmenu.dart';
import 'package:my_restaurant/Intro_Pages/screenpage.dart';
import '../Staff_Mangement/Staff_Management.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 290),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                color: Colors.brown,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(10, 10),
                      blurRadius: 20,
                      color: Colors.brown.withOpacity(1))
                ],
              ),
            ),
          ),
          Positioned(
              child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 85, right: 10, bottom: 20, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1,
                          ),
                          children: [
                            CategoryItemTile(
                              CategoryName: "STAFF MANAGEMENT",
                              ImagePath: "assets/admin/staffs.jpeg",
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return StaffManage();
                                  },
                                ));
                              },
                            ),
                            CategoryItemTile(
                              CategoryName: "VIEW TODAY'S MENU",
                              ImagePath: "assets/admin/food.jpeg",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminMenu()));
                              },
                            ),
                            // CategoryItemTile(
                            //   CategoryName: "CUSTOMER FOOD ORDERS",
                            //   ImagePath: "assets/admin/food_orders.jpeg",
                            //   onPressed: () {},
                            // ),
                            // CategoryItemTile(
                            //   CategoryName: "BILL GENERATING ",
                            //   ImagePath: "assets/admin/bill.jpeg",
                            //   onPressed: () {},
                            // ),
                            CategoryItemTile(
                              CategoryName: "Logout",
                              ImagePath: "assets/admin/exist.jpeg",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScreenPage()));
                              },
                            ),
                          ]),
                    )
                  ],
                )),
          ))
        ],
      ),
    ));
  }
}
