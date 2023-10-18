import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/eventos.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/widgets/CardCalendarWidget.dart';
import 'package:pmsn2023/widgets/CardTaskWidget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  Map<DateTime, List<TaskModel>> eventos = {};
  List <TaskModel> listaTareas = [];
  List <String> fechas = [];
  CalendarFormat format = CalendarFormat.month;
  DateTime DiaSeleccionado = DateTime.now();
  DateTime DiaElegido = DateTime.now();

  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();

    agendaDB = AgendaDB();

    datosTarea();
  }

  Future<void> datosTarea() async{
    listaTareas = await agendaDB!.GETALLTASK();
    setState(() {
      for (var tarea in listaTareas) {
        final fechaTarea = DateTime.parse(tarea.fec_expiracion!);
        if (eventos.containsKey(fechaTarea)) {
          eventos[fechaTarea]!.add(tarea);
        }else{
          eventos[fechaTarea] = [tarea];
          debugPrint('error?');
        }
      }
    });
    actualizar();
  }

  void actualizar(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendario")
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DiaSeleccionado,
            firstDay: DateTime.now(),
            lastDay: DateTime(2100),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onDaySelected: (diaseleccionado, diaelegido) {
              setState(() {
                DiaSeleccionado = diaseleccionado;
                DiaElegido = diaelegido;
                actualizar();
              });
            },
            selectedDayPredicate: (DateTime fecha) {
              return isSameDay(DiaSeleccionado, fecha);
            },
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 30, 109, 174),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 227, 151, 29),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, dia, evento){
                List<Widget> puntos = [];
                final formatoFecha = DateTime.parse(DateFormat('yyyy-MM-dd').format(dia));
                final puntosEve = eventos[formatoFecha] ?? [];
                puntos = puntosEve.map((valueEve) {
                  return Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                    ),
                  );
                }).toList();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: puntos
                );
              }
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: GlobalValue.flagTarea, 
              builder: (context, value, _) {
                return FutureBuilder(
                  future: agendaDB!.FechaTarea(DiaSeleccionado.toString().substring(0,10)), 
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<TaskModel>> snapshot
                  ) {
                    if (snapshot.hasData) {
                      listaTareas = snapshot.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index){
                          return CardCalendarWidget(
                            taskModel: snapshot.data![index],
                            agendaDB: agendaDB,
                          );
                        }
                      );
                    } else{
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Se murio :v'),
                        );
                      }else{
                        return const CircularProgressIndicator();
                      }
                    }
                  }
                );
              }
            )
          )
        ],
      ),
    );
  }
}