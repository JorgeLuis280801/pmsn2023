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
    
    String query = '''CREATE TABLE tblTareas(
      id_Tarea INTEGER primary key,
      nom_Tarea VARCHAR(50),
      desc_Tarea VARCHAR(50),
      sta_Tarea BYTE
    );''';

    db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String,dynamic> data) async {
    
    var conexion = await database;
    return conexion!.insert(tblName, data);

  }

    Future<int> UPDATE(String tblName, Map<String,dynamic> data) async {
    
    var conexion = await database;
    return conexion!.update(tblName, data, 
      where: 'id_Tarea = ?', 
      whereArgs: [data['id_Tarea']]);

  }

  Future<int> DELETE(String tblName, int idTask) async {
    
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