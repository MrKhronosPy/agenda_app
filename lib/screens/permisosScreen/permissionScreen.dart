import 'package:agenda_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Icon(
              Icons.gps_off_rounded,
              color: Colors.green.withOpacity(0.6),
              size: 400,
            ),
          ),
          BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) {
              return !state.isGpsEnabled
                ? const _EnableGpsMessage()
                : const _GpsAccessMessage();
            },
          )
        ]
      )
    );
  }
}

class _GpsAccessMessage extends StatelessWidget {
  const _GpsAccessMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Es Necesario el Acceso al  GPS'),
          MaterialButton(
            shape: const StadiumBorder(),
            elevation: 0,
            color: Colors.green,
            onPressed: (){
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              gpsBloc.askGpsAccess();
            },
            splashColor: Colors.transparent,
            child: const Text(
              'Solicitar Acceso',
              style: TextStyle(
                color: Colors.white
              ),
            )
          )
        ],
      ),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Debe de Activar el GPS',
        style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}