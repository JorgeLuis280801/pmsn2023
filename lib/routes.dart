import 'package:flutter/widgets.dart';
import 'package:pmsn2023/screens/add_carrera.dart';
import 'package:pmsn2023/screens/add_profes.dart';
import 'package:pmsn2023/screens/add_task.dart';
import 'package:pmsn2023/screens/carrera_screen.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
import 'package:pmsn2023/screens/detail_movie_screen.dart';
import 'package:pmsn2023/screens/login_screen.dart';
import 'package:pmsn2023/screens/popular_screen.dart';
import 'package:pmsn2023/screens/product_detail.dart';
import 'package:pmsn2023/screens/profes_screen.dart';
import 'package:pmsn2023/screens/provider_screen.dart';
import 'package:pmsn2023/screens/seleccion_tabla.dart';
import 'package:pmsn2023/screens/task_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext context) => DashboardScreen(),
    '/prod_det' : (BuildContext context) => Product_det(),
    '/task' : (BuildContext context) => TaskScreen(),
    '/addT' : (BuildContext context) => AddTask(),
    '/login' : (BuildContext context) => LoginScreen(),
    '/popular' : (BuildContext context) => PopularScreen(),
    '/detail' : (BuildContext context) => DetailMovieScreen(),
    '/prov' : (BuildContext context) => ProviderScreen(),
    '/profes' : (BuildContext context) => ProfesScreen(),
    '/addP' : (BuildContext context) => AddProfes(),
    '/carreras' : (BuildContext context) => CarreraScreen(),
    '/addC' : (BuildContext context) => AddCarrera(),
    '/selectTbl' : (BuildContext context) => SelectTabla()
  };
}