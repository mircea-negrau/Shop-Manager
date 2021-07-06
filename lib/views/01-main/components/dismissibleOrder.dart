import 'package:flutter/material.dart';

class DismissibleOrder<T> extends StatelessWidget {
  final Widget child;
  final T item;
  final DismissDirectionCallback onDismissed;

  const DismissibleOrder(
      {required this.item,
      required this.child,
      required this.onDismissed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionRight(),
        secondaryBackground: buildSwipeActionLeft(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        child: Icon(Icons.archive_sharp, color: Colors.white, size: 32.0),
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 32.0),
      );
}
