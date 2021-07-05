import 'package:dantelion/services/googleSheetsApi.dart';
import 'package:flutter/material.dart';
import 'components/dateNow.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var date = getDateNow();

  // var authHeaders;
  // var authenticateClient;
  // var driveApi;
  //
  // Future<void> getLoggedIn() async{
  //   final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
  //   final signIn.GoogleSignInAccount account = (await googleSignIn.signIn())!;
  //   print("User account $account");
  //
  //   final authHeaders = await account.authHeaders;
  //   final authenticateClient = GoogleAuthClient(authHeaders);
  //   final driveApi = drive.DriveApi(authenticateClient);
  // }

  @override
  Widget build(BuildContext context) {
    // getLoggedIn();
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final order = Order(
          //   id: 5,
          //   username: 'Nmircea17',
          //   name: 'Mircea',
          //   transportType: 'Posta',
          //   costWithoutTransport: 250,
          //   finalCost: 255,
          //   status: 'Pe drum',
          //   date: DateTime.now(),
          //   details: 'Details',
          // );
          // await ClientSheetsApi.insert([order.toJson()]);

          final orders = await ClientSheetsApi.getAll();
          for (var order in orders) {
            print(order.toJson());
          }
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
