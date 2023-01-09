import 'package:sqflite/sqflite.dart';

class ConexionSqlite{

  static Database? _database;

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB('semillasv1.db');

    return _database!;

  }

  Future<Database> _initDB(String filePath) async {

    final dbpath = await getDatabasesPath();

    final path = '$dbpath/$filePath';

    return await openDatabase(
      path, 
      version: 1, 
      onCreate: _onCreateDB
    );
  }

  Future _onCreateDB(Database db, int version) async {
    print('crear tabla');
    return await db.execute(
      'CREATE TABLE TAREAS(idTarea INTEGER PRIMARY KEY AUTOINCREMENT, fecha TEXT, descripcion TEXT, detalles TEXT, ubicacion TEXT)',
    );
  }

}