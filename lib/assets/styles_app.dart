import 'package:flutter/material.dart';

class StylesApp{
  static ThemeData light_theme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 164, 0, 0),
        secondary: Color.fromARGB(255, 164, 0, 0),
        
      )
    );    
  }

  static ThemeData dark_theme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 227, 151, 29),
        secondary: Color.fromARGB(255, 227, 151, 29),
        
      )
    );
  }
}