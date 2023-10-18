import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/screens/add_task.dart';

class CardCalendarWidget extends StatelessWidget {
  CardCalendarWidget(
    {
      super.key, required this.taskModel, this.agendaDB
    }
  );

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 102, 85)
      ),
      child: 
          Column(
            children: [
              Text(taskModel.nom_tarea!,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
              Text(taskModel.desc_tarea!,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
              Checkbox(
                value: taskModel.realizada == 0
                  ? false
                  : true, 
                onChanged: (isHecho){}
              )
            ],
          ),
    );
  }
}