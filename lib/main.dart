import 'dart:ffi';

import 'package:concentric_transition/concentric_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/assets/styles_app.dart';
import 'package:pmsn2023/provider/test_provider.dart';
import 'package:pmsn2023/routes.dart';
import 'package:pmsn2023/screens/login_screen.dart';
import 'package:pmsn2023/screens/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmsn2023/servicio_notif.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  bool theme = prefs.getBool('theme') ?? false;

  bool remember = prefs.getBool('Recuerdame') ?? false;

  runApp(MyApp(
    theme: theme,
    remember: remember,
  ));

}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.theme, required this.remember});

  final bool theme;
  final bool remember;

  @override
  Widget build(BuildContext context) {

    GlobalValue.flagTheme.value = theme;

    return ValueListenableBuilder(
      valueListenable: GlobalValue.flagTheme,
      
      builder: (context, value, _) {
        return ChangeNotifierProvider(
          create: (context) => TestProvider(),
          child: MaterialApp(
            initialRoute: (remember ? '/dash' : '/login') ?? '/login',
            routes: getRoutes(),
            theme: value ? StylesApp.dark_theme(context) : StylesApp.light_theme(context)
          ),
        );
      }
    );
  }
}