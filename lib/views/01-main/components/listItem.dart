import 'package:dantelion/models/order.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

Widget buildListTile(Order item) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    leading: CircleAvatar(
      radius: 28,
      backgroundColor: Colors.black,
      child: Text(
        item.username[0].toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.username,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(item.status),
      ],
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(elapsedTime(item.date, item.time)),
        const SizedBox(
          height: 4,
        ),
        Text(item.itemsCost.toString() + " RON"),
      ],
    ),
  );
}

String elapsedTime(String date, String time) {
  var elapsed = Jiffy(date + " " + time, "dd/MM/yyyy h:mm:ss a").fromNow();
  return elapsed;
}
