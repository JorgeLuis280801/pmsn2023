import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2023/models/carrera_model.dart';
import 'package:pmsn2023/models/profes_model.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDB {
  
  static final nameDB = 'AGENDADB';
  static final versionDB = 4;

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
    
    String query1 = '''CREATE TABLE tblCarrera(
                        id_Carrera INTEGER primary key,
                        nom_Carrera VARCHAR(50)
                      );''';

    String query2 = '''CREATE TABLE tblProfesor(
                        id_Profe INTEGER primary key,
                        nom_Profe VARCHAR(50),
                        email VARCHAR(50),
                        id_Carrera INTEGER,
                        FOREIGN KEY (id_Profe) REFERENCES tblCarrera(id_Carrera)
                       );''';
    
    String query3 = '''CREATE TABLE tblTareas(
                        id_Tarea INTEGER primary key,
                        nom_tarea VARCHAR(50),
                        fec_expiracion DATE,
                        fec_recordatorio DATE,
                        desc_tarea TEXT,
                        realizada INTEGER,
                        id_Profe INTEGER,
                        FOREIGN KEY (id_Profe) REFERENCES tblProfesor(id_Profe)
                      );''';

    db.execute(query1);
    db.execute(query2);
    db.execute(query3);
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

  Future<int> DELETEProf(String tblName, int idProfe) async {
    
    var conexion = await database;
    return conexion!.delete(tblName, 
      where: 'id_Profe = ?',
      whereArgs: [idProfe]);

  }

  Future<int> DELETECarr(String tblName, int idCarrera) async {
    
    var conexion = await database;
    return conexion!.delete(tblName, 
      where: 'id_Carrera = ?',
      whereArgs: [idCarrera]);

  }

  Future<List<TaskModel>> GETALLTASK() async{

    var conexion = await database;
    
    var result = await conexion!.query('tblTareas');

    return result.map((task) => TaskModel.fromMap(task)).toList();

  }

  Future<List<TaskModel>> FILTROTASK(String NombreT) async{

    var conexion = await database;
    
    var result = await conexion!.query('tblTareas', where: 'nom_tarea = ?', whereArgs: [NombreT]);

    return result.map((task) => TaskModel.fromMap(task)).toList();

  }

  Future<List<TaskModel>> FEstTASK(int Estado) async{

    var conexion = await database;
    
    var result = await conexion!.query('tblTareas', where: 'realizada = ?', whereArgs: [Estado]);

    return result.map((task) => TaskModel.fromMap(task)).toList();

  }

  Future<List<ProfesModel>> GETALLPROFES() async{

    var conexion = await database;
    
    var result = await conexion!.query('tblProfesor');

    return result.map((profes) => ProfesModel.fromMap(profes)).toList();

  }

  Future<List<int>> GETPROFESID() async{

    var conexion = await database;
    
    var result = await conexion!.query('tblProfesor', columns: ['id_Profe']);

    return result.map<int>((map) => map['id_Profe'] as int).toList();

  } 

  Future<List<ProfesModel>> FILTROPROFES(String NombreP) async{

    var conexion = await database;
    
    var result = await conexion!.query('tblProfesor', where: 'nom_Profe = ?', whereArgs: [NombreP]);

    return result.map((profes) => ProfesModel.fromMap(profes)).toList();

  }

  Future<List<CarreraModel>> GETALLCARRERAS() async{

    var conexion = await database;
    
    var result = await conexion!.query('tblCarrera');

    return result.map((carreras) => CarreraModel.fromMap(carreras)).toList();

  }

  Future<List<int>> GETCARRERASID() async{

    var conexion = await database;
    
    var result = await conexion!.query('tblCarrera', columns: ['id_Carrera']);

    return result.map<int>((map) => map['id_Carrera'] as int).toList();

  } 

  Future<List<CarreraModel>> FILTROCARRERAS(String NombreC) async{

    var conexion = await database;
    
    var result = await conexion!.query('tblCarrera', where: 'nom_Carrera = ?', whereArgs: [NombreC]);

    return result.map((carreras) => CarreraModel.fromMap(carreras)).toList();

  } 

}