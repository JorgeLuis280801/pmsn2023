import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/profes_model.dart';
import 'package:pmsn2023/widgets/CardProfesWidget.dart';

class ProfesScreen extends StatefulWidget {
  const ProfesScreen({super.key});

  @override
  State<ProfesScreen> createState() => _ProfesScreenState();
}

class _ProfesScreenState extends State<ProfesScreen> {

  AgendaDB? agendaDB;

  TextEditingController txtconFiltroP = TextEditingController();

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {

  final txtFiltroP = TextField(
    decoration: const InputDecoration(
        label: Text('Indique el nombre del profesor', style: TextStyle(color: Colors.white),),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0))
        ),
    ),
    controller: txtconFiltroP,
  );

  final btnFiltro = ElevatedButton(
    onPressed: (){setState(() {
      
    });}, 
    child: Text('Buscar'),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 30, 109, 174))
  ),
  );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profesores'),
        actions: [
          btnFiltro,
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/addP')
            .then((value){
              setState(() {
                
              });
            }), 
            icon: Icon(Icons.task))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight), 
          child: 
          Padding(
            padding: EdgeInsets.all(3.0),
            child: txtFiltroP,
          )
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValue.flagProfes,
        builder: (context, value, _){
          return FutureBuilder(
            future: txtconFiltroP.text.isEmpty
              ? agendaDB!.GETALLPROFES()
              : agendaDB!.FILTROPROFES(txtconFiltroP.text), 
            builder: (BuildContext context, AsyncSnapshot<List<ProfesModel>> snapshot){
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int  index){
                    return CardProfesWidget(
                      profesModel: snapshot.data![index],
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
            }
          );
        },
      ),
    );
  }
}