import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/carrera_model.dart';
import 'package:pmsn2023/screens/add_carrera.dart';

class CardCarreraWidget extends StatelessWidget {
  CardCarreraWidget({
    super.key,
    required this.carreraModel,
    this.agendaDB
  });

  CarreraModel carreraModel;
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
              Text(carreraModel.nom_Carrera!,
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
                    (context) => AddCarrera(carreraModel: carreraModel,)
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
                        content: const Text("Estas seguro de querer borrar esta carrera?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              agendaDB!.DELETECarr('tblCarrera', carreraModel.id_Carrera!)
                              .then((value) {
                                Navigator.pop(context);
                                GlobalValue.flagCarrera.value = !GlobalValue.flagCarrera.value;
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