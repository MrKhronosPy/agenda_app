import 'package:agenda_app/blocs/blocs.dart';
import 'package:agenda_app/views/views.dart';
import 'package:agenda_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {

    locationBloc = BlocProvider.of<LocationBloc>(context);

    locationBloc.startFollowingUser();

    super.initState();

  }

  @override
  void dispose() {

    locationBloc.stopFolowingUser();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {

          if(state.lastKnowLocation == null) return const Center(child: Text('Espere por favor....'),);

          return SingleChildScrollView(
            child: Stack(
              children: [
                MapView(initialLocation: state.lastKnowLocation!),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}