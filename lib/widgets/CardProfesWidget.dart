import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/profes_model.dart';
import 'package:pmsn2023/screens/add_profes.dart';

class CardProfesWidget extends StatelessWidget {
  CardProfesWidget({
    super.key,
    required this.profesModel,
    this.agendaDB
  });

  ProfesModel profesModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 102, 85)
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(profesModel.nom_Profe!,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
              Text(profesModel.email!,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: 
                    (context) => AddProfes(profesModel: profesModel,)
                  )
                ),
                child: Image.asset('assets/images/P2.jpg', height: 40)
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context){
                      return AlertDialog(
                        title: const Text("Confirmacion de borrado!!"),
                        content: const Text("Estas seguro de querer borrar este profesor?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              agendaDB!.DELETEProf('tblProfesor', profesModel.id_Profe!)
                              .then((value) {
                                Navigator.pop(context);
                                GlobalValue.flagProfes.value = !GlobalValue.flagProfes.value;
                              });
                            }, 
                            child: const Text('Borrar',
                            style: TextStyle(color: Color.fromARGB(255, 0, 177, 27)))
                          ),
                          TextButton(
                            onPressed: ()=>Navigator.pop(context), 
                            child: const Text('Cancelar',
                            style: TextStyle(color: Color.fromARGB(255, 222, 0, 0)),)
                          ),
                        ],
                      );
                    }
                  );
                }, 
                icon: const Icon(Icons.delete)
              )
            ],
          )
        ],
      ),
    );
  }
}