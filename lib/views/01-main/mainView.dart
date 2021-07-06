import 'package:dantelion/models/order.dart';
import 'package:dantelion/services/googleSheetsApi/OrderSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/ArchivedSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/DeletedSheetsApi.dart';
import 'package:dantelion/views/01-main/components/listItem.dart';
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
    final orders = await OrderSheetsApi.getAll();
    setState(() {
      _orders = orders;
    });
    return _orders;
  }

  @override
  void initState() {
    _fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, addOrder),
      body: mainBody(),
    );
  }

  mainBody() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final item = _orders[index];
          return DismissibleOrder(
            item: item,
            child: buildListTile(item),
            onDismissed: (direction) => dismissItem(context, index, direction),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: _orders.length);
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Archived"),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case DismissDirection.endToStart:
        OrderSheetsApi.deleteById(_orders[index].id!);
        DeletedSheetsApi.insert([_orders[index].toJson()]);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Deleted"),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      default:
        break;
    }
    setState(() {
      _orders.removeAt(index);
    });
  }
}
