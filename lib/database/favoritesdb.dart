import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2023/models/favorites_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesDB{

  static final nameDB = 'favoriteDB';
  static final versionDB = 2;

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
    
    String query1 = '''CREATE TABLE tblFavoritos(
                        id_Pelicula INTEGER primary key,
                        clave_P INTEGER,
                        titulo VARCHAR(50),
                        sinopsis text,
                        valoracion double,
                        poster text
                      );''';

    db.execute(query1);
  }

  Future<int> INSERT(String tblName, Map<String,dynamic> data) async {
    
    var conexion = await database;
    return conexion!.insert(tblName, data);

  }

  Future<List<FavoriteModel>> GETALLFAV() async{
    var conexion = await database;
    
    var result = await conexion!.query('tblFavoritos');

    return result.map((fav) => FavoriteModel.fromMap(fav)).toList();
  }
  
  Future<int> DELETEFav(String tblName, int idPeli) async {
    
    var conexion = await database;
    return conexion!.delete(tblName, 
      where: 'clave_P = ?',
      whereArgs: [idPeli]);

  }

  Future<bool> MovieExist(int id_P) async{

    var conexion = await database;
    
    var result = await conexion!.query('tblFavoritos', where: 'clave_P = ?', whereArgs: [id_P]);

    return result.isNotEmpty;

  }

}