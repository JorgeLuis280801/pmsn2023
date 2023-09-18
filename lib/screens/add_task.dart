import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  @override
  Widget build(BuildContext context) {
  
  TextEditingController txtConNomT = TextEditingController();
  TextEditingController txtConDescT = TextEditingController();
  String dropDownValue = "Pendiente";
  List<String> dropDownValues = [
    'Pendiente',
    'Realizando',
    'Concluida',
    'Incompleta'
  ];

  final txtNom_Tarea = TextField(
    controller: txtConNomT,
  );

  final txtDesc_Tarea = TextField(
    maxLines: 65,
    controller: txtConDescT,
  );

  final DropdownButton ddSta_Tarea = DropdownButton(
    value: dropDownValue,
    items: dropDownValues.map((status) => DropdownMenuItem(
      value: status,
      child: Text(status))
    ).toList(), 
    onChanged: (value){
      dropDownValue = value;
      setState(() {
        
      });
    }
  );

  final ElevatedButton btnGuardar =
    ElevatedButton(
      onPressed: (){}, 
      child: Text("Guardar Tarea")
  );

    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir tarea"),
      ),
      body: Column(
        children: [
          txtNom_Tarea,
          txtDesc_Tarea,
          ddSta_Tarea,
          btnGuardar
        ],
      ),
    );
  }
}