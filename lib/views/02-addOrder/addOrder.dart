import 'package:dantelion/views/02-addOrder/components/fields.dart';
import 'package:dantelion/views/02-addOrder/components/backAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/submitButton.dart';

class AddOrderView extends StatefulWidget {
  const AddOrderView({Key? key}) : super(key: key);

  @override
  _AddOrderViewState createState() => _AddOrderViewState();
}

class _AddOrderViewState extends State<AddOrderView> {
  late String _transportType = 'Poștă';
  final categories = ["Poștă", "Curier", "Fizic", "Publi24"];
  final _formKey = GlobalKey<FormState>();
  final _dropdownKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final transportCostController = TextEditingController();
  final finalCostController = TextEditingController();
  final detailsController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    transportCostController.dispose();
    finalCostController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(context),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: addOrderForm(),
                ),
              ),
            ),
          ),
        ));
  }

  Column addOrderForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        textField("Username", usernameController, false),
        separator(),
        textField("Name", nameController, false),
        separator(),
        dropDownField(),
        separator(),
        numberField("Transport cost", transportCostController),
        separator(),
        numberField("Final cost", finalCostController),
        separator(),
        textField("Details", detailsController, false),
        separator(),
        SubmitNewOrderButton(
          formKey: _formKey,
          usernameController: usernameController,
          nameController: nameController,
          transportType: _transportType,
          transportCostController: transportCostController,
          detailsController: detailsController,
        ),
      ],
    );
  }

  FormField<String> dropDownField() {
    return FormField<String>(
      key: _dropdownKey,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: dropDownFieldInputDecoration(),
          isEmpty: _transportType == '',
          child: buildDropdownButtonHideUnderline(state),
        );
      },
    );
  }

  DropdownButtonHideUnderline buildDropdownButtonHideUnderline(
      FormFieldState<String> state) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _transportType,
        isDense: true,
        onChanged: (String? newTransportType) {
          setState(() {
            _transportType = newTransportType!;
            state.didChange(_transportType);
          });
        },
        items: categories.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.pink,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
