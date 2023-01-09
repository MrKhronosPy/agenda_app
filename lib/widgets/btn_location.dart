import 'package:agenda_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agenda_app/blocs/blocs.dart';
import 'package:flutter/material.dart';

class BtnCurrentLocation extends StatelessWidget {

  const BtnCurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final locationBloc = BlocProvider.of<LocationBloc>(context);

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.green,
        maxRadius: 25,
        child: IconButton(
          onPressed: (){

            final userLocation = locationBloc.state.lastKnowLocation;

            if(userLocation == null){
              
              final snackBar = CustomSnackBar(message: 'No Hay Ubicacion',);

              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              return;

            }

            mapBloc.moveCamera(userLocation);

          }, 
          icon: const Icon(
            Icons.my_location_outlined,
            color: Colors.white,
          )
        ),
      ),
    );
  }
}