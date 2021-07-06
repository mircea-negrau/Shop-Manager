import 'dart:convert';

class OrderFields {
  static final String id = 'ID';
  static final String username = 'Username';
  static final String name = 'Name';
  static final String transportType = 'Transport';
  static final String transportCost = 'Transport cost';
  static final String itemsCost = 'Items cost';
  static final String status = 'Status';
  static final String date = 'Date';
  static final String time = 'Time';
  static final String details = 'Details';

  static List<String> getFields() => [
        id,
        username,
        name,
        transportType,
        transportCost,
        itemsCost,
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
  final int transportCost;
  final int itemsCost;
  final String status;
  final String date;
  final String time;
  final String details;

  const Order({
    this.id,
    required this.username,
    required this.name,
    required this.transportType,
    required this.transportCost,
    required this.itemsCost,
    required this.status,
    required this.date,
    required this.time,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      OrderFields.id: this.id,
      OrderFields.username: this.username,
      OrderFields.name: this.name,
      OrderFields.transportType: this.transportType,
      OrderFields.transportCost: this.transportCost,
      OrderFields.itemsCost: this.itemsCost,
      OrderFields.status: this.status,
      OrderFields.date: this.date,
      OrderFields.time: this.time,
      OrderFields.details: this.details,
    };
  }

  static Order fromJson(Map<String, dynamic> json) {
    String date = json[OrderFields.date];
    return Order(
      id: jsonDecode(json[OrderFields.id]),
      username: json[OrderFields.username],
      name: json[OrderFields.name],
      transportType: json[OrderFields.transportType],
      transportCost: jsonDecode(json[OrderFields.transportCost]),
      itemsCost: jsonDecode(json[OrderFields.itemsCost]),
      status: json[OrderFields.status],
      date: date,
      time: json[OrderFields.time],
      details: json[OrderFields.details],
    );
  }
}
