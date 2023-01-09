import 'package:agenda_app/constants.dart';
import 'package:flutter/material.dart';

class ButtonGenerate{

  static MaterialButton getButtonStandar(
    BuildContext context,
    Function ejecutar,
    String texto,
  ){
    return MaterialButton(
      elevation: 0,
      color: primaryColor,
      onPressed: (() => ejecutar()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 50),
      child: Text(texto,
        style: const TextStyle(
        color: Colors.white,
        ),
      ),
    );
  }

}