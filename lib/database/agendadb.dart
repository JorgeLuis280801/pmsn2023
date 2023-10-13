import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDB {
  
  static final nameDB = 'AGENDADB';
  static final versionDB = 1;

  static Database? _database;
  
  Future<Database?> get database async {
    if (_database != null)
    return _database!;
    return _database = await _initdatabase();
  }
  
  Future<Database?> _initdatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String PathDB = join(folder.path,nameDB);
    return openDatabase(
      PathDB,
      version: versionDB,
      onCreate: _createTables
    );
  }

  FutureOr<void> _createTables(Database db, int version) {
    
    String query = '''CREATE TABLE tblCarrera(
                        id_Carrera INTEGER primary key,
                        nom_Carrera VARCHAR(50)
                      );

                      CREATE TABLE tblProfesor(
                        id_Profe INTEGER primary key,
                        nom_Profe VARCHAR(50),
                        email VARCHAR(50),
                        id_Carrea INTEGER,
                        FOREIGN KEY (id_Profe) REFERENCES tblCarrera(id_Carrera)
                      );

                      CREATE TABLE tblTareas(
                        id_Tarea INTEGER primary key,
                        nom_tarea VARCHAR(50),
                        fec_expiracion DATE,
                        fec_Recordatorio DATE,
                        desc_tarea TEXT,
                        realizada INTEGER,
                        id_Profe INTEGER,
                        FOREIGN KEY (id_Profe) REFERENCES tblProfesor(id_Profe)
                      );
                      ''';

    db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String,dynamic> data) async {
    
    var conexion = await database;
    return conexion!.insert(tblName, data);

  }

  Future<int> UPDATETar(String tblName, Map<String,dynamic> data) async {
    
    var conexion = await database;
    return conexion!.update(tblName, data, 
      where: 'id_Tarea = ?', 
      whereArgs: [data['id_Tarea']]);

  }

  Future<int> UPDATEProf(String tblName, Map<String,dynamic> data) async {
    
    var conexion = await database;
    return conexion!.update(tblName, data, 
      where: 'id_Profe = ?', 
      whereArgs: [data['id_Profe']]);

  }

  Future<int> UPDATECarr(String tblName, Map<String,dynamic> data) async {
    
    var conexion = await database;
    return conexion!.update(tblName, data, 
      where: 'id_Carrera = ?', 
      whereArgs: [data['id_Carrera']]);

  }

  Future<int> DELETETar(String tblName, int idTask) async {
    
    var conexion = await database;
    return conexion!.delete(tblName, 
      where: 'id_Tarea = ?',
      whereArgs: [idTask]);

  }

  Future<List<TaskModel>> GETALLTASK() async{

    var conexion = await database;
    var result = await conexion!.query('tblTareas');

    return result.map((task) => TaskModel.fromMap(task)).toList();

  } 

}