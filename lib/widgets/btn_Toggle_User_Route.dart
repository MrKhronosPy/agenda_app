import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agenda_app/blocs/blocs.dart';
import 'package:flutter/material.dart';

class BtnToggleUserRoute extends StatelessWidget {

  const BtnToggleUserRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.green,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              onPressed: (){
    
                mapBloc.add(OnToggleUserRoute());
    
              }, 
              icon: Icon(
                state.showMyRoute ? Icons.close_rounded : Icons.more_horiz_rounded,
                color: Colors.white,
              )
            );
          },
        ),
      ),
    );
  }
}