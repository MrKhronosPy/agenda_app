import 'package:agenda_app/constants.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {

  const DrawerMenu(GlobalKey<ScaffoldState> scaffoldKey, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: primaryColor
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: 250,
                margin: const EdgeInsets.only(top: 10),
              ),
              const SizedBox(height: 15,),
              const Center(
                child: Text(
                  'Nombre Apellido',
                  style: TextStyle(
                      fontSize: 18,
                      color: tertiaryColor,
                      fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          )
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month), 
          title: const Text('Ver tareas'),
          onTap: () {
            Navigator.pushNamed(context, 'vistatareas');
          }
        ),
      ]),
    );
  }
}
