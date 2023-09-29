import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  String? dropDownValue = "Pendiente";

  TextEditingController txtConNomT = TextEditingController();
  TextEditingController txtConDescT = TextEditingController();
  
  List<String> dropDownValues = [
    'Pendiente',
    'Realizando',
    'Concluida'
  ];

  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();

    if (widget.taskModel != null) {
      
      txtConNomT.text = widget.taskModel!.nom_Tarea!;
      txtConDescT.text = widget.taskModel!.desc_tarea!; 

      switch (widget.taskModel!.sta_Tarea) {
        case 'R':
          dropDownValue = "Realizando";
          break;
        case 'C':
          dropDownValue = "Concluida";
          break;
        case 'P':
          dropDownValue = "Pendiente";
      }
    }

  }

  @override
  Widget build(BuildContext context) {

  final txtNom_Tarea = TextField(
    decoration: const InputDecoration(
      label: Text('Tarea'),
      border: OutlineInputBorder()
    ),
    controller: txtConNomT,
  );

  final txtDesc_Tarea = TextField(
    decoration: const InputDecoration(
      label: Text('Descripcion'),
      border: OutlineInputBorder()
    ),
    maxLines: 6,
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
      onPressed: (){
        if( widget.taskModel == null){
          agendaDB!.INSERT('tblTareas', {
          'nom_Tarea' : txtConNomT.text,
          'desc_Tarea' : txtConDescT.text,
          'sta_Tarea' : dropDownValue!.substring(0,1)
        }).then((value){
          var msj = ( value > 0 ) ? 'Insercion exitosa' : 'Insercion fallida';
          var snackbar = SnackBar(content: Text(msj));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
        });
        }else{
          AgendaDB()!.UPDATE('tblTareas', {
            'id_Tarea' : widget.taskModel!.id_Tarea,
            'nom_Tarea' : txtConNomT.text,
            'desc_Tarea' : txtConDescT.text,
            'sta_Tarea' : dropDownValue!.substring(0,1)
          }).then((value) {
            GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;
            var msj = ( value > 0 ) 
            ? 'Actualizacion exitosa' 
            : 'Error en la actualizacion';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        }
      }, 
      child: Text("Guardar Tarea")
  );

    return Scaffold(
      appBar: AppBar(
        title: widget.taskModel == null 
        ? const Text("Añadir tarea")
        : const Text("Editar tarea"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 8.0),
            txtNom_Tarea,
            const SizedBox(height: 15.0),
            txtDesc_Tarea,
            const SizedBox(height: 15.0),
            ddSta_Tarea,
            const SizedBox(height: 15.0),
            btnGuardar
          ],
        ),
      ),
    );
  }
}