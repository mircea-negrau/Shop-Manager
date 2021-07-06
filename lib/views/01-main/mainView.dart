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
  List<Order> _orders = [];

  _fetchOrders() async {
    _orders = await OrderSheetsApi.getAll();
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar(context, addOrder),
        body: ListView.separated(
            itemBuilder: (context, index) {
              final item = _orders[index];
              return DismissibleOrder(
                item: item,
                child: buildListTile(item),
                onDismissed: (direction) =>
                    dismissItem(context, index, direction),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: _orders.length));
  }

  Future<void> addOrder(BuildContext context, order) async {
    if (order.runtimeType == Null) return;
    setState(() {
      _orders.add(order);
    });
  }

  Future<void> dismissItem(
      BuildContext context, int index, DismissDirection direction) async {
    switch (direction) {
      case DismissDirection.startToEnd:
        OrderSheetsApi.deleteById(_orders[index].id!);
        ArchivedSheetsApi.insert([_orders[index].toJson()]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Archived"),
          duration: Duration(seconds: 2),
        ));
        break;
      case DismissDirection.endToStart:
        OrderSheetsApi.deleteById(_orders[index].id!);
        DeletedSheetsApi.insert([_orders[index].toJson()]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Deleted"),
          duration: Duration(seconds: 2),
        ));
        break;
      default:
        break;
    }
    setState(() {
      _orders.removeAt(index);
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
