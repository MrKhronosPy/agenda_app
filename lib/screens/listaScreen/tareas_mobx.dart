import 'dart:convert';

import 'package:agenda_app/database/conexion_sqlite.dart';
import 'package:agenda_app/models/tarea.dart';
import 'package:mobx/mobx.dart';

import '../../models/shared_pref.dart';

// Include generated file
part 'tareas_mobx.g.dart';

// This is the class used by rest of your codebase
class Listatareas = _Listatareas with _$Listatareas;

// The store-class
abstract class _Listatareas with Store {

  Tareas? _tareas = Tareas();

  static ObservableFuture<List<Tarea?>?>? emptyResponse = ObservableFuture.value([]);

  @observable
  ObservableList<Tarea?>? tareas = ObservableList();

  @observable
  ObservableFuture<List<Tarea?>?>? fetchTodosFuture = emptyResponse;

  @observable
  int cantidadTareas = 0;

  @computed
  ObservableList<Tarea?>? get visibleTodos {
    return tareas;
  }

  @computed
  bool get hasResults =>
    fetchTodosFuture != emptyResponse &&
    fetchTodosFuture?.status == FutureStatus.fulfilled;

  _Listatareas() {
    fetchTodos();
  }  

  @action
  recargar() {
    fetchTodos();
    print('recargar..');
  }

  @action
  Future<List<Tarea?>?> fetchTodos() async {

    tareas?.clear();

    final future = getTodos();

    fetchTodosFuture = ObservableFuture(future);

    return tareas = ObservableList.of(await future);

  }

  @action
  Future eliminarTarea(Tarea tarea) async {

    final db = await ConexionSqlite().database;

    await db.delete(
      'TAREAS',
      where: "idTarea = ?",
      whereArgs: [tarea.idTarea],
    );

    fetchTodos();

  }

  Future<List<Tarea?>> getTodos() async {

    final db = await ConexionSqlite().database;

    final List<Map<String, dynamic>> maps = await db.query('TAREAS');

    _tareas?.tareas = List.generate(maps.length, (i) {

      Iterable listaUbicacion = maps[i]['ubicacion'];
      listaUbicacion.map((model) => Ubicacion.fromJson(model)).toList();

      return Tarea(
        idTarea: maps[i]['idTarea'],
        fecha: maps[i]['fecha'],
        descripcion: maps[i]['descripcion'],
        detalles: maps[i]['detalles'],
        ubicacion: List<Ubicacion?>.from(listaUbicacion),
        //ubicacion: List<Ubicacion?>.from(jsonDecode(maps[i]['ubicacion']).map((x) => Ubicacion.fromJson(x))),
      );

    });

    return _tareas?.tareas ?? [];

  }
  
}