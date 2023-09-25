import 'package:flutter/material.dart';

class checkbox extends StatefulWidget {
  const checkbox({Key? key}) : super(key:key);

  @override
  State<checkbox> createState() => _checkboxState();
}

class _checkboxState extends State<checkbox> {
  bool? check = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Row(
            children: [
              Checkbox(
                value: check,
                activeColor: Colors.red,
                onChanged: (newCheck) {
                  setState(() {
                    check = newCheck;
                  });
                },
              ),
              Text('Hola',
              style: TextStyle(color: Colors.black),)
            ],
          ),
        ),

      )
      );
  }
}