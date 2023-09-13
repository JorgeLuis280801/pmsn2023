import 'package:flutter/widgets.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
import 'package:pmsn2023/screens/product_detail.dart';
import 'package:pmsn2023/screens/task_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext context) => DashboardScreen(),
    '/prod_det' : (BuildContext context) => Product_det(),
    '/task' : (BuildContext context) => TaskScreen()
  };
}