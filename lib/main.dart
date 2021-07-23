import 'package:clone_olx/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeParse();
  runApp(MyApp());

}

Future<void> initializeParse() async {
    await Parse().initialize('IKNuhcaVLvNM4Exaz0lbrlAKbF6xYYIMbtzmalPQ',
      'https://parseapi.back4app.com/',
      debug: true,
      autoSendSessionId: true,
      clientKey: 'yeEofSNdV1lKlAdEErae3PTv7dl5VeIArmB9J5oQ');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olx Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaseScreen(),
    );
  }
}
