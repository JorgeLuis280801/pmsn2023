import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/profes_model.dart';

class AddProfes extends StatefulWidget {
  AddProfes({super.key, this.profesModel});

  ProfesModel? profesModel;

  @override
  State<AddProfes> createState() => _AddProfesState();
}

class _AddProfesState extends State<AddProfes> {

  int? Carreras;

  TextEditingController txtConNomProfe = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();

  List <int> CarrerasValue = [];

  List <String> CarrerasName = [];

  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();

    if (widget.profesModel != null) {
      txtConNomProfe.text = widget.profesModel!.nom_Profe!;
      txtConEmail.text = widget.profesModel!.email!;
      Carreras = widget.profesModel!.id_Carrera!;
      agendaDB!.GETCARRERASID().then((clave){
        setState(() {
          CarrerasValue = clave;
        });
      });
    }

    agendaDB!.GETCARRERASID().then((clave){
        setState(() {
          CarrerasValue = clave;
        });
      });
  }

  @override
  Widget build(BuildContext context) {

    final txtNom_Profe = TextField(
      decoration: const InputDecoration(
        label: Text('Nombre Profesor'),
        border: OutlineInputBorder()
      ),
      controller: txtConNomProfe,
    );

    final txtEmail = TextField(
      decoration: const InputDecoration(
        label: Text('Email'),
        border: OutlineInputBorder()
      ),
      controller: txtConEmail,
    );

    final DropdownButton ddCarrera = DropdownButton<int>(
      value: Carreras,
      items: CarrerasValue.map((id) {
        return DropdownMenuItem<int>(
          value: id,
          child: Text('${CarrerasValue.toString()[id-1]} id: $id')
        );
      }).toList(), 
      onChanged: (value){
        Carreras = value;
        setState(() {
          
        });
      }
    );

    final ElevatedButton btnGuardar =
    ElevatedButton(
      onPressed: (){
        if( widget.profesModel == null){
          agendaDB!.INSERT('tblProfesor', {
          'nom_Profe' : txtConNomProfe.text,
          'email' : txtConEmail.text,
          'id_Carrera' : Carreras
        }).then((value){
          var msj = ( value > 0 ) ? 'Insercion exitosa' : 'Insercion fallida';
          var snackbar = SnackBar(content: Text(msj));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
        });
        }else{
          AgendaDB()!.UPDATETar('tblProfesor', {
            'id_Profe' : widget.profesModel!.id_Profe,
            'nom_Profe' : txtConNomProfe.text,
            'email' : txtConEmail.text,
            'id_Carrera' : Carreras
          }).then((value) {
            GlobalValue.flagProfes.value = !GlobalValue.flagProfes.value;
            var msj = ( value > 0 ) 
            ? 'Actualizacion exitosa' 
            : 'Error en la actualizacion';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        }
      }, 
      child: Text("Guardar Profesor")
  );

    return Scaffold(
      appBar: AppBar(
        title: widget.profesModel == null
          ? const Text('Añadir Profesor')
          : const Text('Editar Profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            txtNom_Profe,
            const SizedBox(height: 10.0),
            txtEmail,
            const SizedBox(height: 10.0),
            ddCarrera,
            const SizedBox(height: 10.0),
            btnGuardar
          ],
        ),
      ),
    );
  }
}