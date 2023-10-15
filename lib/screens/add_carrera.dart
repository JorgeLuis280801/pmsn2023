import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/carrera_model.dart';

class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carreraModel});

  CarreraModel? carreraModel;

  @override
  State<AddCarrera> createState() => _AddCarreraState();
}

class _AddCarreraState extends State<AddCarrera> {

  TextEditingController txtConNomCarr = TextEditingController();

  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if (widget.carreraModel != null) {
      txtConNomCarr.text = widget.carreraModel!.nom_Carrera!;
    }
  }

  @override
  Widget build(BuildContext context) {

    final txtNomCarr = TextField(
      decoration: const InputDecoration(
        label: Text('Carrera'),
        border: OutlineInputBorder()
      ),
      controller: txtConNomCarr,
    );

    final ElevatedButton btnGuardar =
      ElevatedButton(
        onPressed: (){
          if( widget.carreraModel == null){
            agendaDB!.INSERT('tblCarrera', {
            'nom_Carrera' : txtConNomCarr.text
          }).then((value){
            var msj = ( value > 0 ) ? 'Insercion exitosa' : 'Insercion fallida';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
          }else{
            AgendaDB()!.UPDATECarr('tblCarrera', {
              'id_Carrera' : widget.carreraModel!.id_Carrera,
              'nom_Carrera' : txtConNomCarr.text,
            }).then((value) {
              GlobalValue.flagCarrera.value = !GlobalValue.flagCarrera.value;
              var msj = ( value > 0 ) 
              ? 'Actualizacion exitosa' 
              : 'Error en la actualizacion';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        }, 
        child: Text("Guardar Carrera")
    );

    return Scaffold(
      appBar: AppBar(
        title: widget.carreraModel == null 
        ? const Text("Añadir carrera")
        : const Text("Editar carrera"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            txtNomCarr,
            const SizedBox(height: 15.0),
            btnGuardar
          ],
        ),
      ),
    );
  }
}