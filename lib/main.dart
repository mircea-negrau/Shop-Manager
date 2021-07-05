import 'package:flutter/material.dart';
import 'package:dantelion/views/taskView.dart';

import 'services/googleSheetsApi.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ClientSheetsApi.init();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dantelion',
      theme: ThemeData(
        primaryColor: Colors.pink[100],
        primarySwatch: Colors.pink,
      ),
      home: TaskView(),
    );
  }
}
