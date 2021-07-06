import 'package:dantelion/services/googleSheetsApi/ArchivedSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/DeletedSheetsApi.dart';
import 'package:flutter/material.dart';
import 'package:dantelion/views/01-main/mainView.dart';

import 'services/googleSheetsApi/OrderSheetsApi.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OrderSheetsApi.init();
  await ArchivedSheetsApi.init();
  await DeletedSheetsApi.init();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dantelion',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MainView(),
    );
  }
}
