import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemTile extends StatelessWidget {
  final String CategoryName;
  final String ImagePath;
  final color;
  void Function()? onPressed;

  CategoryItemTile(
      {Key? key,
      required this.CategoryName,
      required this.ImagePath,
      this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.brown,
            ),
            child: Column(
              children: [
                Flexible(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(10, 10),
                                blurRadius: 20,
                                color: Colors.brown.withOpacity(1))
                          ],
                          image: DecorationImage(
                              image: AssetImage(
                                ImagePath,
                              ),
                              fit: BoxFit.cover)),
                    )),
                Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            CategoryName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.alegreya(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
