import 'package:dantelion/services/googleSheetsApi/ArchivedSheetsApi.dart';
import 'package:dantelion/services/googleSheetsApi/DeletedSheetsApi.dart';
import 'package:flutter/material.dart';
import 'package:dantelion/views/01-main/mainView.dart';

import 'services/googleSheetsApi/OrderSheetsApi.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future initialize() async {
    await OrderSheetsApi.init();
    await ArchivedSheetsApi.init();
    await DeletedSheetsApi.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return ErrorWidget(snapshot.hasError);
          if (snapshot.connectionState == ConnectionState.done)
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Dantelion',
              theme: ThemeData(
                primaryColor: Colors.white,
              ),
              home: MainView(),
            );
          return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ));
        });
  }
}
