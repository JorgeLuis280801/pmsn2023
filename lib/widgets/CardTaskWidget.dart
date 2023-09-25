import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';

class CardTaskWidget extends StatefulWidget {
  CardTaskWidget(
    {
      super.key, required this.taskModel, this.agendaDB
    }
  );

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState extends State<CardTaskWidget> {
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
              Text(widget.taskModel.nom_Tarea!,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
              Text(widget.taskModel.desc_tarea!,
              style: const TextStyle(color: Colors.white)),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: (){},
                child: Image.asset('assets/images/P2.jpg', height: 40)
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context){
                      return AlertDialog(
                        title: const Text("Confirmacion de borrado!!"),
                        content: const Text("Estas seguro de querer borrar esta tarea?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              widget.agendaDB!.DELETE('tblTareas', widget.taskModel.id_Tarea!)
                              .then((value) {
                                Navigator.pop(context);
                                GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;
                              });
                            }, 
                            child: const Text('Borrar',
                            style: TextStyle(color: Color.fromARGB(255, 0, 177, 27)))
                          ),
                          TextButton(
                            onPressed: ()=>Navigator.pop(context), 
                            child: const Text('Cancelar',
                            style: TextStyle(color: Color.fromARGB(255, 177, 0, 0)),)
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