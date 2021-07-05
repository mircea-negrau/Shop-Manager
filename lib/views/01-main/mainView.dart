import 'package:dantelion/models/order.dart';
import 'package:dantelion/services/googleSheetsApi.dart';
import 'package:flutter/material.dart';
import 'package:dantelion/views/01-main/components/dateNow.dart';
import 'package:dantelion/views/01-main/components/mainAppBar.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var date = getDateNow();

  Future<List<Order>> getAllOrders() async {
    final orders = await ClientSheetsApi.getAll();

    for (var order in orders) {
      print(order.toJson());
    }
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: getAllOrders,
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


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