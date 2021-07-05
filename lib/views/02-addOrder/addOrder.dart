import 'package:dantelion/views/01-main/mainView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddOrderView extends StatelessWidget {
  final Animation<double> transitionAnimation;

  const AddOrderView({Key? key, required this.transitionAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: transitionAnimation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1, 0),
            end: Offset(0, 0),
          ).animate(transitionAnimation),
          child: child,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: IconButton(
            icon: Icon(Icons.close),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MainView(),
                  ));
            },
          ),
        ),
        body: Container(),
      ),
    );
  }
}
