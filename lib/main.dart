import 'dart:ffi';

import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/assets/styles_app.dart';
import 'package:pmsn2023/routes.dart';
import 'package:pmsn2023/screens/login_screen.dart';
import 'package:pmsn2023/screens/product_detail.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValue.flagTheme,
      builder: (context, value, _) {
        return MaterialApp(
          home: LoginScreen(),
          routes: getRoutes(),
          theme: value ? StylesApp.dark_theme(context) : StylesApp.light_theme(context)
        );
      }
    );
  }
}

/*class MyApp extends StatefulWidget {
  MyApp({super.key, this.x});
  int? x;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
int Contador = 0;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Text('Contador clicks $Contador', 
           style: TextStyle(fontSize: 30),
           ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.mouse,
            color: Colors.red,
          ),
          onPressed: (){
            Contador++;
            print(Contador);
            setState(() {});
          }
          ),
      ),
    );
  }
}*/