import 'package:dantelion/views/02-addOrder/addOrder.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      "Dantelion",
      style: TextStyle(fontFamily: 'Pacifico'),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.add_box_outlined),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return AddOrderView(transitionAnimation: animation);
              },
              transitionDuration: const Duration(milliseconds: 100),
            ),
          );
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        icon: Icon(Icons.assignment_outlined),
        onPressed: () {},
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    ],
  );
}