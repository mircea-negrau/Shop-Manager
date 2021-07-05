import 'package:flutter/material.dart';

AppBar backAppBar(context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: IconButton(
      icon: Icon(Icons.close),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}
