import 'package:dantelion/models/order.dart';
import 'package:flutter/material.dart';

Widget buildListTile(Order item) => ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.black,
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
    );
