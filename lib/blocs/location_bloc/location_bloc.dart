import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(const LocationState()) {
    
    on<OnStartFollowingUser>((event, emit) => emit( state.copyWith(followingUser: true)));

    on<OnStopFollowingUser>((event, emit) => emit( state.copyWith(followingUser: false)));

    on<OnNewuserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnowLocation: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation!],

      ));
    });

  }

  Future getGetCurrentPosition() async{
    final position = await Geolocator.getCurrentPosition();
    add(OnNewuserLocationEvent(LatLng(position.latitude,position.longitude)));
  }

  void startFollowingUser(){
    add(OnStartFollowingUser());
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position =  event;
      add(OnNewuserLocationEvent(LatLng(position.latitude,position.longitude)));
    });
  }

  void stopFolowingUser(){
    positionStream?.cancel();
    add(OnStopFollowingUser());
  }

  @override
  Future<void> close() {
    stopFolowingUser();
    return super.close();
  }

}
