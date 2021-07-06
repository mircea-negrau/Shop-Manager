import 'package:dantelion/models/order.dart';
import 'package:dantelion/services/googleSheetsApi/OrderSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/ArchivedSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/DeletedSheetsApi.dart';
import 'package:dantelion/views/01-main/components/listItem.dart';
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
  List<Order> _archived = [];
  int _selectedIndex = 0;
  bool _showOrders = true;
  int _sum = 0;
  int _transportSum = 0;

  _fetchOrders() async {
    final orders = await OrderSheetsApi.getAll();
    setState(() {
      _orders = orders;
    });
    return _orders;
  }

  _fetchArchived() async {
    final archived = await ArchivedSheetsApi.getAll();
    setState(() {
      _archived = archived;
    });
    return _archived;
  }

  @override
  void initState() {
    _fetchOrders();
    _fetchArchived();
    super.initState();
  }

  showArchived() {
    setState(() {
      _selectedIndex = 0;
      _showOrders = !_showOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, addOrder, showArchived, _showOrders),
      body: mainBody(),
      bottomNavigationBar: mainBottomNavBar(),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  mainBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
      ],
    );
  }

  mainBody() {
    if (_selectedIndex == 0) {
      if (_showOrders)
        return ListView.separated(
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
          itemCount: _orders.length,
        );
      else
        return ListView.separated(
          itemBuilder: (context, index) {
            final item = _archived[index];
            return DismissibleOrder(
              item: item,
              child: buildListTile(item),
              onDismissed: (direction) =>
                  dismissItem(context, index, direction),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _archived.length,
        );
    } else {
      _sum = 0;
      for (var order in _orders) {
        _sum += order.itemsCost;
        _transportSum += order.transportCost;
      }
      return Container(
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "PROFIT: $_sum RON",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  "TRANSPORT: $_transportSum RON",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Future<void> addOrder(BuildContext context, order) async {
    if (order.runtimeType == Null) return;
    setState(() {
      _orders.insert(0, order);
    });
  }

  Future<void> dismissItem(
      BuildContext context, int index, DismissDirection direction) async {
    switch (direction) {
      case DismissDirection.startToEnd:
        OrderSheetsApi.deleteById(_orders[index].id!);
        ArchivedSheetsApi.insert([_orders[index].toJson()]);
        _archived.insert(0, _orders[index]);
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
