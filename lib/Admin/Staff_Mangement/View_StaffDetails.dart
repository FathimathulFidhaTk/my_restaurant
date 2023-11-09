import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewStaffProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StaffList(),
      ),
    );
  }
}

class StaffList extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('staff').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final Stafflist = snapshot.data!.docs;
        return ListView.builder(
          itemBuilder: (context, index) {
            final staffitem = Stafflist[index];
            return StaffItemCard(staffItem: staffitem);
          },
          itemCount: snapshot.data!.docs.length,
        );
      },
    );
  }
}

class StaffItemCard extends StatelessWidget {
  final QueryDocumentSnapshot staffItem;

  StaffItemCard({required this.staffItem});

  Future<void> _deleteItem() async {
    await staffItem.reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = staffItem['imageUrl'] ?? 'URL_TO_FALLBACK_IMAGE';
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.brown),
            boxShadow: [
              BoxShadow(
                offset: Offset(10, 10),
                blurRadius: 20,
                color: Colors.transparent.withOpacity(1),
              )
            ]),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80, right: 20, top: 20),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 80,
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Image.network(
              //       imageUrl),
              // ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 90, top: 15),
                  child: Text(
                    "Name :",
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    staffItem['name'],
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 15),
                  child: Text(
                    "Gender :",
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    staffItem['gender'],
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 10),
                  child: Text(
                    "Date of Birth :",
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    staffItem['dateofbirth'],
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 88, top: 10),
                    child: Text(
                      "Phone :",
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      staffItem['phone'],
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 95, top: 10),
                    child: Text(
                      "Email :",
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 20,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      staffItem['mail'],
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 95, top: 10),
                    child: Text(
                      "Place :",
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      staffItem['place'],
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 10),
                    child: Text(
                      "Job Type :",
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      staffItem['jobtype'],
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Date of Joining :",
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      staffItem['dateofjoining'],
                      style: GoogleFonts.alegreya(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 22,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ],
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 45, top: 10),
                  child: Text(
                    "Experience :",
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    staffItem['experience'],
                    style: GoogleFonts.alegreya(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 280),
                child: IconButton(
                    onPressed: _deleteItem,
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.brown,
                      size: 30,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
