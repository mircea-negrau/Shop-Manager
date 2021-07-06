import 'package:dantelion/models/order.dart';
import 'package:dantelion/services/googleSheetsApi/OrderSheetsApi.dart';
import 'package:flutter/material.dart';

class SubmitNewOrderButton extends StatelessWidget {
  const SubmitNewOrderButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.nameController,
    required String transportType,
    required this.transportCostController,
    required this.detailsController,
  })   : _formKey = formKey,
        _transportType = transportType,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController nameController;
  final String _transportType;
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
          int finalCost = int.tryParse(transportCostController.text)!;
          int costWithoutTransport =
              finalCost - int.tryParse(transportCostController.text)!;
          var day = DateTime.now().day.toString();
          var month = DateTime.now().month.toString();
          var year = DateTime.now().year.toString();
          var hour = DateTime.now().hour.toString();
          var minute = DateTime.now().minute.toString();
          var second = DateTime.now().second.toString();
          var time = hour + ":" + minute + ":" + second;
          var date = day + "/" + month + "/" + year;
          var details = detailsController.text;

          print(date);
          print(time);

          Order newOrder = Order(
            id: id,
            username: username,
            name: name,
            transportType: transportType,
            costWithoutTransport: costWithoutTransport,
            finalCost: finalCost,
            date: date,
            time: time,
            details: details,
            status: "TO SEND",
          );
          OrderSheetsApi.insert([newOrder.toJson()]);
          Navigator.of(context).pop();
        }
      },
    );
  }
}
