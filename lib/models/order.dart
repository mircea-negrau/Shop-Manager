import 'dart:convert';
import 'package:flutter/material.dart';

class OrderFields {
  static final String id = 'ID';
  static final String username = 'Username';
  static final String name = 'Name';
  static final String transportType = 'Transport';
  static final String costWithoutTransport = 'Cost without transport';
  static final String finalCost = 'Final cost';
  static final String status = 'Status';
  static final String date = 'Date';
  static final String time = 'Time';
  static final String details = 'Details';

  static List<String> getFields() => [
    id,
    username,
    name,
    transportType,
    costWithoutTransport,
    finalCost,
    status,
    date,
    time,
    details
  ];
}

class Order {
  final int? id;
  final String username;
  final String name;
  final String transportType;
  final int costWithoutTransport;
  final int finalCost;
  final String status;
  final String date;
  final String details;

  const Order({
    this.id,
    required this.username,
    required this.name,
    required this.transportType,
    required this.costWithoutTransport,
    required this.finalCost,
    required this.status,
    required this.date,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
    OrderFields.id: this.id,
    OrderFields.username: this.username,
    OrderFields.name: this.name,
    OrderFields.transportType: this.transportType,
    OrderFields.costWithoutTransport: this.costWithoutTransport,
    OrderFields.finalCost: this.finalCost,
    OrderFields.status: this.status,
    OrderFields.date: this.date.toString(),
    OrderFields.time: this.date.toString(),
    OrderFields.details: this.details,
  };

  static Order fromJson(Map<String, dynamic> json) => Order(
    id: jsonDecode(json[OrderFields.id]),
    username: json[OrderFields.username],
    name: json[OrderFields.name],
    transportType: json[OrderFields.transportType],
    costWithoutTransport: jsonDecode(json[OrderFields.costWithoutTransport]),
    finalCost: jsonDecode(json[OrderFields.finalCost]),
    status: json[OrderFields.status],
    date: json[OrderFields.date],
    details: json[OrderFields.details],
  );
}
