import 'package:agenda_app/models/tarea.dart';
import 'package:agenda_app/screens/tareaScreen/agregar_tarea_controller.dart';
import 'package:agenda_app/widgets/appbar_generate.dart';
import 'package:agenda_app/widgets/button_generate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AgregarTareaScreen extends StatefulWidget {

  final Tarea? tarea;

  const AgregarTareaScreen({super.key, this.tarea});

  @override
  State<AgregarTareaScreen> createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {

  final AgregarTareaController _agregarTareaController = AgregarTareaController();

  late GoogleMapController googleMapController;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _agregarTareaController.init(context);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    const CameraPosition _kLake = 
      CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414
      );

    _agregarTareaController.tareaOrig = widget.tarea;
    _agregarTareaController.preparaEdicion();

    return Scaffold(
      appBar: AppBarGenerate.getAppBarStandar(context, 'Agregar Tarea'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text('Descripcion'),
            TextField(
              controller: _agregarTareaController.tareaDescripcion,
            ),
            const SizedBox(height: 20,),
            const Text('Detalles'),
            TextField(
              controller: _agregarTareaController.tareaDetalles,
            ),
            const SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(8),
              width: 400,
              height: 450,
              child: GoogleMap(
                initialCameraPosition: _kLake,
                mapType: MapType.hybrid,
                compassEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (GoogleMapController controller) async{
                  
                  googleMapController = controller;

                  Position position = await Geolocator.getCurrentPosition();

                  if(position != null){
                    googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
                  }
                   
                },
              )
            ),
            ButtonGenerate.getButtonStandar(context,(){guardarRegistro();}, 'Guardar'),
          ],
        ),
      ),
    );
  }

  guardarRegistro(){
    _agregarTareaController.guardaRegistro();
    Navigator.of(context).pop();
  }

}