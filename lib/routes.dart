import 'package:flutter/widgets.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
import 'package:pmsn2023/screens/product_detail.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext context) => DashboardScreen(),
    '/prod_det' : (BuildContext context) => Product_det()
  };
}