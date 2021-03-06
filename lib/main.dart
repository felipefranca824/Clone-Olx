import 'package:clone_olx/repository/category_repository.dart';
import 'package:clone_olx/repository/cep_repository.dart';
import 'package:clone_olx/repository/ibge_repository.dart';
import 'package:clone_olx/screens/base/base_screen.dart';
import 'package:clone_olx/stores/category/category_store.dart';
import 'package:clone_olx/stores/page_store.dart';
import 'package:clone_olx/stores/user_manager_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(MyApp());

}

void setupLocators(){
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
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
      debugShowCheckedModeBanner: false,
      title: 'Olx Clone',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.purple,
        appBarTheme: AppBarTheme(elevation: 0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      home: BaseScreen(),
    );
  }
}
