import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/carrera_model.dart';
import 'package:pmsn2023/widgets/CardCarreraWidget.dart';

class CarreraScreen extends StatefulWidget {
  const CarreraScreen({super.key});

  @override
  State<CarreraScreen> createState() => _CarreraScreenState();
}

class _CarreraScreenState extends State<CarreraScreen> {

  AgendaDB? agendaDB;

  TextEditingController txtconFiltroC = TextEditingController();

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {

  final txtFiltroC = TextField(
    decoration: const InputDecoration(
        label: Text('Indique el nombre de la carrera', style: TextStyle(color: Colors.white),),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255))
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0))
        ),
    ),
    controller: txtconFiltroC,
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
        title: const Text('Carreras'),
        actions: [
          btnFiltro,
          IconButton(
            onPressed: ()=>Navigator.pushNamed(context, '/addC')
            .then((value){
              setState(() {
                
              });
            }), 
            icon: Icon(Icons.task)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight), 
          child: 
          Padding(
            padding: EdgeInsets.all(3.0),
            child: txtFiltroC,
          )
        ),
      ),
      body: 
      ValueListenableBuilder(
        valueListenable:  GlobalValue.flagCarrera,
        builder: (context, value, _) {
          return FutureBuilder(
            future: txtconFiltroC.text.isEmpty
              ? agendaDB!.GETALLCARRERAS()
              : agendaDB!.FILTROCARRERAS(txtconFiltroC.text),
            builder: (BuildContext contex, AsyncSnapshot<List<CarreraModel>> snapshot){
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int  index){
                    return CardCarreraWidget(
                      carreraModel: snapshot.data![index],
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