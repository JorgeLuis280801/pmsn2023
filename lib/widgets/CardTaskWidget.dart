import 'package:flutter/material.dart';
import 'package:pmsn2023/models/task_model.dart';

class CardTaskWidget extends StatelessWidget {
  CardTaskWidget({super.key, required this.taskModel});

  TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(taskModel.nom_Tarea!),
              Text(taskModel.desc_tarea!),
            ],
          )
        ],
      ),
    );
  }
}