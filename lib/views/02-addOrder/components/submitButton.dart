import 'package:dantelion/models/order.dart';
import 'package:dantelion/services/googleSheetsApi.dart';
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
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          var username = usernameController.text;
          var name = nameController.text;
          var transportType = _transportType;
          int finalCost = int.tryParse(transportCostController.text)!;
          int costWithoutTransport =
              finalCost - int.tryParse(transportCostController.text)!;
          var day = DateTime.now().day.toString();
          var month = DateTime.now().month.toString();
          var year = DateTime.now().year.toString();
          var date = day + "/" + month + "/" + year;
          var details = detailsController.text;

          Order newOrder = Order(
            username: username,
            name: name,
            transportType: transportType,
            costWithoutTransport: costWithoutTransport,
            finalCost: finalCost,
            date: date,
            details: details,
            status: "TO SEND",
          );
          ClientSheetsApi.insert([newOrder.toJson()]);
          Navigator.of(context).pop();
        }
      },
    );
  }
}