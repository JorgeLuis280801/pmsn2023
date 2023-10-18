import 'package:flutter/material.dart';
import 'package:pmsn2023/eventos.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  Map<DateTime, List<Eventos>> eventosSeleccionados = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime DiaSeleccionado = DateTime.now();
  DateTime DiaElegido = DateTime.now();

  TextEditingController txtconEventos = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<Eventos> ObtenerEventos(DateTime date) {
    return eventosSeleccionados[date] ?? [];
  }

  @override
  void dispose() {
    txtconEventos.dispose();
    super.dispose();
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
            onDaySelected: (DateTime diaseleccionado, DateTime diaelegido) {
              setState(() {
                DiaSeleccionado = diaseleccionado;
                DiaElegido = diaelegido;
              });
            },
            selectedDayPredicate: (DateTime fecha) {
              return isSameDay(DiaSeleccionado, fecha);
            },
            eventLoader: ObtenerEventos,
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
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ...ObtenerEventos(DiaSeleccionado).map(
            (Eventos evento) => ListTile(
              title: Text(
                evento.titulo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}