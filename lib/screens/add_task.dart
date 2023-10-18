import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  int? tareaHecha = 0;
  int? profe;

  DateTime? fec_exp;
  DateTime? fec_rec;

  TextEditingController txtConNomT = TextEditingController();
  TextEditingController txtConDescT = TextEditingController();
  TextEditingController txtConFecExp = TextEditingController();
  TextEditingController txtConFecRec = TextEditingController();
  
  List <int> tareahechavalues = [
    0,
    1
  ];

  List<int> profeValues = [];

  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();

    if (widget.taskModel != null) {
      
      txtConNomT.text = widget.taskModel!.nom_tarea!;
      txtConFecExp.text = widget.taskModel!.fec_expiracion!.toString();
      txtConFecRec.text = widget.taskModel!.fec_recordatorio!.toString();
      txtConDescT.text = widget.taskModel!.desc_tarea!;
      
      switch (widget.taskModel!.realizada) {
        case 0:
          tareaHecha = 0;
          break;
        case 1:
          tareaHecha = 1;
      }

      agendaDB!.GETPROFESID().then((clave) {
        setState(() {
          profeValues = clave;
        });
      });
      
    }

    agendaDB!.GETPROFESID().then((clave) {
        setState(() {
          profeValues = clave;
        });
    });

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

  final txtFecExp = TextField(
    decoration: const InputDecoration(
      icon: Icon(Icons.calendar_today),
      label: Text('Fecha Expiracion'),
      border: OutlineInputBorder()
    ),
    readOnly: true,
    controller: txtConFecExp,
    onTap: () async {
      DateTime? FecExp = await showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime.now(), 
        lastDate: DateTime(2100),
        cancelText: ''
      );
      if (FecExp != null) {
        String FecExpF = DateFormat('yyyy-MM-dd').format(FecExp);
        fec_exp = DateFormat('yyyy-MM-dd').parse(FecExpF);
        setState(() {
          txtConFecExp.text = FecExpF;
        });
      }else{
        var snackbar = SnackBar(content: Text('No se ha elegido ninguna fecha!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.pop(context);
      }
    },
  );

  final txtFecRec = TextField(
    decoration: const InputDecoration(
      icon: Icon(Icons.calendar_today),
      label: Text('Fecha Recordatorio'),
      border: OutlineInputBorder()
    ),
    controller: txtConFecRec,
    onTap: () async {
      DateTime? FecRec = await showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime.now(), 
        lastDate: DateTime(2100),
        cancelText: ''
      );
      if (FecRec != null) {        
        String FecRecF = DateFormat('yyyy-MM-dd').format(FecRec);
        fec_rec = DateFormat('yyyy-MM-dd').parse(FecRecF);
        setState(() {
          txtConFecRec.text = FecRecF;
        });
      }else{
        var snackbar = SnackBar(content: Text('No se ha elegido ninguna fecha!'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.pop(context);
      }
    },
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
    value: tareaHecha,
    items: tareahechavalues.map((status) => DropdownMenuItem(
      value: status,
      child: Text(status.toString()))
    ).toList(), 
    onChanged: (value){
      tareaHecha = value;
      setState(() {
        
      });
    }
  );

  final DropdownButton ddProfes = DropdownButton<int>(
    value: profe,
    items: profeValues.map((id) => DropdownMenuItem<int>(
      value: id,
      child: Text('${profeValues.toString()[id-1]} id: $id'))
    ).toList(), 
    onChanged: (value){
      profe = value;
      setState(() {
        
      });
    }
  );

  final ElevatedButton btnGuardar =
    ElevatedButton(
      onPressed: (){
        if( widget.taskModel == null){
          agendaDB!.INSERT('tblTareas', {
          'nom_tarea' : txtConNomT.text,
          'fec_expiracion' : txtConFecExp.text,
          'fec_recordatorio' : txtConFecRec.text,
          'desc_tarea' : txtConDescT.text,
          'realizada' : tareaHecha
        }).then((value){
          var msj = ( value > 0 ) ? 'Insercion exitosa' : 'Insercion fallida';
          var snackbar = SnackBar(content: Text(msj));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
        });
        }else{
          AgendaDB()!.UPDATETar('tblTareas', {
            'id_Tarea' : widget.taskModel!.id_Tarea,
            'nom_tarea' : txtConNomT.text,
            'fec_expiracion' : txtConFecExp.text,
            'fec_recordatorio' : txtConFecRec.text,
            'desc_tarea' : txtConDescT.text,
            'realizada' : tareaHecha
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
            txtFecExp,
            const SizedBox(height: 15.0),
            txtFecRec,
            const SizedBox(height: 15.0),
            ddSta_Tarea,
            const SizedBox(height: 15.0),
            ddProfes,
            const SizedBox(height: 15.0),
            btnGuardar
          ],
        ),
      ),
    );
  }
}