import 'package:flutter/material.dart';

class SelectTabla extends StatefulWidget {
  const SelectTabla({super.key});

  @override
  State<SelectTabla> createState() => _SelectTablaState();
}

class _SelectTablaState extends State<SelectTabla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliga la tabla que quiere consultar'),
      ),
      body: ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget> [
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 102, 85)
          ),
          child: Row(
            children: [
              const Text('Tareas',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context, '/task'
                ),
                child: Image.asset('assets/images/P2.jpg', height: 40)
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 102, 85)
          ),
          child: Row(
            children: [
              const Text('Profesores',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context, '/profes'
                ),
                child: Image.asset('assets/images/P2.jpg', height: 40)
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 102, 85)
          ),
          child: Row(
            children: [
              const Text('Carreras',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 251, 127), fontSize: 16)),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context, '/carreras'
                ),
                child: Image.asset('assets/images/P2.jpg', height: 40)
              )
            ],
          ),
        )
      ],
    )
    );
  }
}