import 'package:dantelion/models/order.dart';
import 'package:dantelion/services/googleSheetsApi/OrderSheetsApi.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class SubmitNewOrderButton extends StatelessWidget {
  const SubmitNewOrderButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.nameController,
    required String transportType,
    required this.itemsCostController,
    required this.transportCostController,
    required this.detailsController,
  })   : _formKey = formKey,
        _transportType = transportType,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController nameController;
  final String _transportType;
  final TextEditingController itemsCostController;
  final TextEditingController transportCostController;
  final TextEditingController detailsController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.pink,
      ),
      child: Text(
        "Add",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          int id = await OrderSheetsApi.getNextId();
          var username = usernameController.text;
          var name = nameController.text;
          var transportType = _transportType;
          int itemsCost = int.tryParse(itemsCostController.text)!;
          int transportCost = int.tryParse(transportCostController.text)!;
          String date = Jiffy().format("dd/MM/yyyy");
          String time = Jiffy().format("h:mm:ss a");
          var details = detailsController.text;

          Order newOrder = Order(
            id: id,
            username: username,
            name: name,
            transportType: transportType,
            transportCost: transportCost,
            itemsCost: itemsCost,
            date: date,
            time: time,
            details: details,
            status: "TO SEND",
          );
          OrderSheetsApi.insert([newOrder.toJson()]);
          Navigator.of(context).pop(newOrder);
        }
      },
    );
  }
}
