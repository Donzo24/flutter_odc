import 'package:flutter/material.dart';
import 'package:flutter_application_1/entity/user_entity.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/nav/index.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'database.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  // await database.utilisateurDao.insertUtilisateur(Utilisateur(nom: "Donzo", prenom: "Youssouf", telephone: "62000000"));

  runApp(
    MyFirstApp(
      database: database,
    )
  );
}

class MyFirstApp extends StatelessWidget {
  MyFirstApp({super.key, required this.database});

  AppDatabase database;


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      title: "ODC APP",
      home: IndexPage(),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
 