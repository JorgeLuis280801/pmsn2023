import 'package:flutter/material.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.task))
        ],
      ),
      body: FutureBuilder(
        future: agendaDB!.GETALLTASK(),
        builder: (BuildContext contex, AsyncSnapshot<List<TaskModel>> snapshot){
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 1, //snapshot.data!.length,
              itemBuilder: (BuildContext context, int  index){
                return Text('Estoy cansado gfe :c');
              }
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('E we se nos cayo el sistema!! :v'),
              );
            } else{
              return CircularProgressIndicator();
            }
          }
        }),
    );
  }
}