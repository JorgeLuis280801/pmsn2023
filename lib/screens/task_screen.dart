import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/widgets/CardTaskWidget.dart';

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
        title: const Text('Task manager'),
        actions: [
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/addT')
            .then((value){
              setState(() {
                
              });
            }), 
            icon: Icon(Icons.task))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable:  GlobalValue.flagTarea,
        builder: (context, value, _) {
          return FutureBuilder(
            future: agendaDB!.GETALLTASK(),
            builder: (BuildContext contex, AsyncSnapshot<List<TaskModel>> snapshot){
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int  index){
                    return CardTaskWidget(
                      taskModel: snapshot.data![index],
                      agendaDB: agendaDB
                    );
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
            });
        }
      ),
    );
  }
}