import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField textField(
    String text, TextEditingController controller, bool required) {
  return TextFormField(
    autocorrect: false,
    controller: controller,
    keyboardType: TextInputType.text,
    validator: (value) {
      if (required && (value == null || value.isEmpty))
        return "Please fill this field";
      return null;
    },
    decoration: InputDecoration(
      labelText: text,
      filled: true,
      isDense: true,
      labelStyle: TextStyle(
        color: Colors.pink,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
      ),
    ),
  );
}

TextFormField numberField(String text, TextEditingController controller) {
  return TextFormField(
    autocorrect: false,
    controller: controller,
    keyboardType: TextInputType.numberWithOptions(signed: true),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
    ],
    validator: (value) {
      if (value == null || value.isEmpty) return "Please fill this field";
      return null;
    },
    decoration: InputDecoration(
      labelText: text,
      filled: true,
      isDense: true,
      labelStyle: TextStyle(
        color: Colors.pink,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
      ),
    ),
  );
}

InputDecoration dropDownFieldInputDecoration() {
  return InputDecoration(
    errorStyle: TextStyle(color: Colors.redAccent),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink),
    ),
  );
}

SizedBox separator() {
  return SizedBox(
    height: 12,
  );
}
