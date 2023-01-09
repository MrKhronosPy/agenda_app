import 'package:agenda_app/database/conexion_sqlite.dart';
import 'package:agenda_app/models/tarea.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class AgregarTareaController{

  late BuildContext context;

  TextEditingController tareaDescripcion = TextEditingController();

  TextEditingController tareaDetalles = TextEditingController();

  Tarea? tarea = Tarea();

  Tarea? tareaOrig = Tarea();

  Future init(BuildContext context) async{

    this.context = context;

  }

  preparaEdicion(){

    if(tareaOrig != null){

      tareaDescripcion.text = tareaOrig?.descripcion ?? '';
      tareaDetalles.text = tareaOrig?.detalles ?? '';

    }

  }

  guardaRegistro() async{

    if(tareaOrig == null){

      tarea?.descripcion = tareaDescripcion.text;
      tarea?.detalles = tareaDetalles.text;

      final db = await ConexionSqlite().database;

      int id = await db.insert(
        'TAREAS',
        tarea!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );

      print('Id: $id');

    }else{

      tarea?.idTarea =  tareaOrig?.idTarea; 
      tarea?.fecha = tareaOrig?.fecha;
      tarea?.descripcion = tareaDescripcion.text;
      tarea?.detalles = tareaDetalles.text;
      tarea?.ubicacion = tareaOrig?.ubicacion;

      final db = await ConexionSqlite().database;

      return await db.update(
        'TAREAS',
        tarea!.toJson(),
        where: "idTarea=?",
        whereArgs: [tareaOrig?.idTarea],
      );

    }

    // if(tareaOrig == null){

    //   tarea?.descripcion = tareaDescripcion.text;
    //   tarea?.detalles = tareaDescripcion.text;

    //   _tareas = Tareas.fromJson(await _sharedPrefc.read('tareas') ?? {});

    //   _tareas?.tareas?.add(tarea);

    //   _sharedPrefc.save('tareas', _tareas?.toJson());

    // }else{
      
    //   tarea?.descripcion = tareaDescripcion.text;
    //   tarea?.detalles = tareaDetalles.text;

    //   _tareas = Tareas.fromJson(await _sharedPrefc.read('tareas') ?? {});

    //   int? indexRegistro = _tareas?.tareas?.indexOf(tareaOrig);

    //   _tareas?.tareas?[indexRegistro ?? 0] = tarea;

    //   _sharedPrefc.save('tareas', _tareas?.toJson());

    // }

  }

}