import 'package:agenda_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {

  final LatLng initialLocation;

  final Set<Polyline> polylines;

  const MapView({
    super.key, 
    required this.initialLocation, 
    required this.polylines
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

  final CameraPosition initialCameraPosition = CameraPosition(
    target: widget.initialLocation,
    zoom: 14
  );

  final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) => mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          mapType: MapType.hybrid, //da problemas en el emulador el hibrido
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: widget.polylines,
          onMapCreated: (GoogleMapController controller) {
            mapBloc.add(OnMapInitializedEvent(controller));
          },
        ),
      ),
    );
  }
}