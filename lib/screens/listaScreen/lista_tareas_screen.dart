import 'package:agenda_app/models/tarea.dart';
import 'package:agenda_app/screens/listaScreen/tareas_mobx.dart';
import 'package:agenda_app/screens/tareaScreen/agregar_tarea_screen.dart';
import 'package:agenda_app/widgets/appbar_generate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key});

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();

}

class _ListaTareasScreenState extends State<ListaTareasScreen> {

  final Listatareas tareas = Listatareas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenerate.getAppBarStandar(context, 'Lista de Tareas'),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        heroTag: 'addTareaButton',
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AgregarTareaScreen())).then((value) => tareas.recargar());
        }, 
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _listViewTareas(),
    );
  }

  Widget _listViewTareas() {

    return Observer(

      builder: (_) {

        if(!tareas.hasResults){
          return Container();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(5),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, i) => _usuarioListTile( tareas.visibleTodos![i] ), 
          itemCount: tareas.visibleTodos?.length ?? 0
        );
        
      }
    );

  }

  Widget _usuarioListTile( Tarea? tarea ) {

    String descripcion = tarea?.descripcion ?? '';
    //String avatar = descripcion.length > 1 ? descripcion.substring(0,2) : descripcion.substring(0,1);

    return Card(
      child: Slidable(
        key: ValueKey(descripcion),
        startActionPane: ActionPane(
          motion: const DrawerMotion(), 
          children: [
            SlidableAction(
              onPressed: (context){
                tareas.eliminarTarea(tarea!);
                setState(() {});
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Eliminar',
            ),
          ]
        ),
        child: ListTile(
          title: Text(descripcion),
          leading: const CircleAvatar(
            backgroundColor: Colors.greenAccent,
            child: Text(''),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarTareaScreen(tarea: tarea,))).then((value) => tareas.recargar());
          },
        )
      ),
    );
  }
}
