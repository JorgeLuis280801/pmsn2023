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

  String estado = "Todas";

  List <String> estadovalues = [
    'Todas',
    'Completadas',
    'Pendientes'
  ];

  List <TaskModel> tareas = [];

  TextEditingController txtconFiltroT = TextEditingController();

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    initTareas();
  }

  @override
  Widget build(BuildContext context) {

  final txtFiltroT = TextField(
    decoration: const InputDecoration(
        label: Text('Indique el nombre de la tarea', style: TextStyle(color: Colors.white),),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0))
        ),
    ),
    controller: txtconFiltroT,
  );

  final btnFiltro = ElevatedButton(
    onPressed: (){
      FiltroTareas(txtconFiltroT.text);
      setState(() {
        
      });
    }, 
    child: Text('Buscar'),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 30, 109, 174))
  ),
  );

  final DropdownButton ddEstado = DropdownButton(
    value: estado,
    items: estadovalues.map((status) => DropdownMenuItem(
      value: status,
      child: Text(status.toString()))
    ).toList(), 
    onChanged: (newEstado) {
      setState(() {
        estado = newEstado!;
        actEstado();
        GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;
      });
    }
  );
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task manager'),
        actions: [
          btnFiltro,
          ddEstado,
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/addT')
            .then((value){
              setState(() {
                
              });
            }), 
            icon: Icon(Icons.task)
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight), 
          child: 
          Padding(
            padding: EdgeInsets.all(3.0),
            child: txtFiltroT,
          )
        ),
      ),
      body: 
      ValueListenableBuilder(
        valueListenable:  GlobalValue.flagTarea,
        builder: (context, value, _) {
          return FutureBuilder(
            future: agendaDB!.GETALLTASK(),
            builder: (BuildContext contex, AsyncSnapshot<List<TaskModel>> snapshot){
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: tareas.length,
                  itemBuilder: (BuildContext context, int  index){
                    return CardTaskWidget(
                            taskModel: tareas[index],
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

  Future<void> actEstado() async {
    List<TaskModel> ptarea;
    switch (estado) {
      case 'Completadas':
        ptarea = await agendaDB!.FEstTASK(1);
        GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;
        break;
      case 'Pendientes':
        ptarea = await agendaDB!.FEstTASK(0);
        GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;
        break;
      default:
        ptarea = await agendaDB!.GETALLTASK();
        GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;
    }

    setState(() {
      // Actualizar la lista de tareas
      tareas = ptarea;
    });
  }

  Future<void> initTareas() async {
    List<TaskModel> ptarea;

    ptarea = await agendaDB!.GETALLTASK();
    GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;

    setState(() {
      // Actualizar la lista de tareas
      tareas = ptarea;
    });
  }

  Future<void> FiltroTareas(String filtro) async {
    List<TaskModel> ptarea;

    ptarea = await agendaDB!.FILTROTASK(filtro);
    GlobalValue.flagTarea.value = !GlobalValue.flagTarea.value;

    setState(() {
      // Actualizar la lista de tareas
      tareas = ptarea;
    });
  }

}