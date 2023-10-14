import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_restaurant/Intro_Pages/screenpage.dart';
import 'package:my_restaurant/Kitchen/kitchen_home.dart';
import '../Admin/viewfoodmenu.dart';
import '../Kitchen/Prepared_Orders.dart';
import '../Kitchen/kitchen_menu/Kitchen_food_screen.dart';
import '../Kitchen/kitchenfeedback.dart';
import 'drawer_header.dart';

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
      home:  HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {

    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = kitchenHome();
    } else if (currentPage == DrawerSections.events) {
      container = KitchenMenu();
    } else if (currentPage == DrawerSections.notes) {
      container = AdminMenu();
    } else if (currentPage == DrawerSections.settings) {
      // container = SettingsPage();
    } else if (currentPage == DrawerSections.notifications) {
      container = PreparedOrders();
    } else if (currentPage == DrawerSections.privacy_policy) {
      container = ViewFeedback();
    } else if (currentPage == DrawerSections.send_feedback) {
      // container = ;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.brown,
          title: Text("Restaurant",
          style: GoogleFonts.alegreya(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 24,
          color: Colors.white,
          ),),
        ),
      ),
      body: container,
      drawer: Drawer(
        width: Get.width * 0.75,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),),
          color: Colors.brown,
          boxShadow: [
          BoxShadow(
          offset: Offset(10, 10),
        blurRadius: 20,
        color: Colors.brown.withOpacity(1.0))
    ],

      ),
      height: Get.height * 0.55,
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(3, "Add Menu", Icons.restaurant_menu,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "View Menu", Icons.menu_book_sharp,
              currentPage == DrawerSections.notes ? true : false),
          menuItem(5, "View Orders", Icons.library_books_sharp,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Prepared Orders", Icons.send,
              currentPage == DrawerSections.notifications ? true : false),
          menuItem(7, "FeedBacks", Icons.feedback,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(8, "Logout", Icons.logout,
              currentPage == DrawerSections.send_feedback ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.brown : Colors.brown,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.white,
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

enum DrawerSections {
  dashboard,
  contacts,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}