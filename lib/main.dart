import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:agenda_app/constants.dart';
import 'package:agenda_app/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agenda_app/screens/screens.dart';


final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  GestureBinding.instance.resamplingEnabled = true;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
      ], 
      child: const MyApp()
    )
  );

}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'AgendApp',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      color: Colors.green,
      theme: semillasTheme,
      initialRoute: 'loading',
      routes: {
        'login' :(context) => const LoginScreen(),
        'home' :(context) => const HomeScreen(),
        'vistatareas' :(context) => const ListaTareasScreen(),
        'gpspermission' :(context) =>  const PermissionScreen(),
        'maps' :(context) => const MapScreen(),
        'loading' :(context) => const LoadingScreen(),
      },
    );
  }
}
