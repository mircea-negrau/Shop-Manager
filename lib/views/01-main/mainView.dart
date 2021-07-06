import 'dart:async';
import 'package:dantelion/models/order.dart';
import 'package:dantelion/services/googleSheetsApi/OrderSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/ArchivedSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/DeletedSheetsApi.dart';
import 'package:dantelion/views/02-addOrder/addOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dantelion/views/01-main/components/mainAppBar.dart';
import 'package:dantelion/views/01-main/components/dismissibleOrder.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  _fetchOrders() async {
    List orders = await OrderSheetsApi.getAll();
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchOrders(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
              appBar: AppBar(
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
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AddOrderView(),
                          ));
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
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = snapshot.data[index];
                    return DismissibleOrder(
                      item: item,
                      child: buildListTile(item),
                      onDismissed: (direction) =>
                          dismissItem(context, index, direction, snapshot),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data.length));
        }
      },
    );
  }

  Future<void> dismissItem(BuildContext context, int index,
      DismissDirection direction, AsyncSnapshot snapshot) async {
    switch (direction) {
      case DismissDirection.startToEnd:
        await OrderSheetsApi.deleteById(snapshot.data[index].id);
        ArchivedSheetsApi.insert([snapshot.data[index].toJson()]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Archived"),
          duration: Duration(seconds: 2),
        ));
        break;
      case DismissDirection.endToStart:
        await OrderSheetsApi.deleteById(snapshot.data[index].id);
        DeletedSheetsApi.insert([snapshot.data[index].toJson()]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Deleted"),
          duration: Duration(seconds: 2),
        ));
        break;
      default:
        break;
    }
    setState(() {
      snapshot.data.removeAt(index);
    });
  }

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
}

// todo: Dismiss main page of orders and beautify add order. Maybe 2 Google Docs (1 for archives)
// final order = Order(
//   id: 5,
//   username: 'Nmircea17',
//   name: 'Mircea',
//   transportType: 'Posta',
//   costWithoutTransport: 250,
//   finalCost: 255,
//   status: 'Pe drum',
//   date: DateTime.now(),
//   details: 'Details',
// );
// await ClientSheetsApi.insert([order.toJson()]);
