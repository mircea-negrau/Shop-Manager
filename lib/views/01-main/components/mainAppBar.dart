import 'package:dantelion/views/02-addOrder/addOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar(BuildContext context, addOrder, showArchived, showOrders) {
  Icon icon = Icon(Icons.archive_outlined);
  if(!showOrders)
    icon = Icon(Icons.list);
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
        onPressed: () async {
          await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddOrderView(),
              )).then((order) {
            addOrder(context, order);
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      IconButton(
        icon: icon,
        onPressed: showArchived,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    ],
  );
}
