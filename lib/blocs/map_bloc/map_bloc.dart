import 'dart:async';
import 'dart:convert';
import 'package:agenda_app/blocs/blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agenda_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;

  GoogleMapController? _googleMapController;

  StreamSubscription? locationStreamSuscripcion;

  MapBloc({required this.locationBloc}) : super(const MapState()) {

    on<OnMapInitializedEvent>(_onInitMap);

    locationStreamSuscripcion = locationBloc.stream.listen((locationstate) { 

      if(!state.isFollowingUser) return;

      if(locationstate.lastKnowLocation == null) return;

      moveCamera(locationstate.lastKnowLocation!);

    });

  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit){

    _googleMapController = event.controller;

    _googleMapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWith(isMapInitialized: true));

  }

  void moveCamera( LatLng newLocation ){

    final cameraUpdate = CameraUpdate.newLatLng(newLocation);

    _googleMapController?.animateCamera(cameraUpdate);

  }

  @override
  Future<void> close() {
    locationStreamSuscripcion?.cancel();
    return super.close();
  }

}
