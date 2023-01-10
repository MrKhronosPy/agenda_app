import 'dart:async';
import 'dart:convert';
import 'package:agenda_app/blocs/blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agenda_app/themes/themes.dart';
import 'package:flutter/material.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;

  GoogleMapController? _googleMapController;

  StreamSubscription? locationStreamSuscripcion;

  MapBloc({required this.locationBloc}) : super(const MapState()) {

    on<OnMapInitializedEvent>(_onInitMap);

    on<OnStartFollowingUserEvent>(_onStartFollowingUser);

    on<OnStopFollowingUserEvent>((event, emit) => emit( state.copyWith(isFollowingUser: false)));

    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);

    on<OnToggleUserRoute>((event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    locationStreamSuscripcion = locationBloc.stream.listen((locationstate) { 

      if(locationstate.lastKnowLocation != null){
        add(UpdateUserPolylineEvent(locationstate.myLocationHistory));
      }

      if(!state.isFollowingUser) return;

      if(locationstate.lastKnowLocation == null) return;

      moveCamera(locationstate.lastKnowLocation!);

    });

  }

  void _onStartFollowingUser(OnStartFollowingUserEvent event,Emitter<MapState> emit){

    emit( state.copyWith(isFollowingUser: true));

    if(locationBloc.state.lastKnowLocation == null) return;

    moveCamera(locationBloc.state.lastKnowLocation!);

  }

  void _onPolylineNewPoint(UpdateUserPolylineEvent event,Emitter<MapState> emit){

    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations,
    );


    final currentPolylines = Map<String,Polyline>.from( state.polylines );

    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));

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
