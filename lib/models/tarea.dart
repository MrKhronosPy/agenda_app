// To parse this JSON data, do
//
//     final tarea = tareaFromJson(jsonString);

import 'dart:convert';

Tareas tareaFromJson(String str) => Tareas.fromJson(json.decode(str));

String tareaToJson(Tareas data) => json.encode(data.toJson());

class Tareas {
  Tareas({
    this.tareas,
  });

  List<Tarea?>? tareas;

  factory Tareas.fromJson(Map<String?, dynamic> json) => Tareas(
    tareas: json["tareas"] ==  null ? [] : List<Tarea>.from(json["tareas"].map((x) => Tarea.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "tareas": tareas == null ? [] : List<dynamic>.from(tareas!.map((x) => x!.toJson())),
  };
}

class Tarea {
  Tarea({
    this.idTarea,
    this.fecha,
    this.descripcion,
    this.detalles,
    this.ubicacion,
  });

  int? idTarea;
  String? fecha;
  String? descripcion;
  String? detalles;
  List<Ubicacion?>? ubicacion;

  factory Tarea.fromJson(Map<String?, dynamic> json) => Tarea(
    idTarea: json["idTarea"],
    fecha: json["fecha"],
    descripcion: json["descripcion"],
    detalles: json["detalles"],
    ubicacion: List<Ubicacion>.from(json["coordenadaJson"].map((x) => Ubicacion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "idTarea": idTarea,
    "fecha": fecha,
    "descripcion": descripcion,
    "detalles": detalles,
    "ubicacion": ubicacion == null ? [] : List<Ubicacion>.from(ubicacion!.map((x) => x!.toJson())),
  };

}

class Ubicacion {
  Ubicacion({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Ubicacion.fromJson(Map<String?, dynamic> json) => Ubicacion(
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String?, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
