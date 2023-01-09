import 'package:agenda_app/constants.dart';
import 'package:flutter/material.dart';

class AppBarGenerate{

  static getAppBarStandar(
    BuildContext context,
    String title,
  ){
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        }
      ),
      title: Text(title),
    );
  }

  static getAppBarSearching(
    Function cancelSearch, 
    TextEditingController searchController
  ){
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            cancelSearch();
          }),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofocus: true,
          decoration: const InputDecoration(
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  static PreferredSizeWidget getAppBarNotSearching(
    String title, 
    Function startSearchFunction
  ){
    return AppBar(
      title: Text(title),
        elevation: 0,
        backgroundColor: primaryColor,
        actions: <Widget>[
          IconButton(
            onPressed: startSearchFunction(), 
            icon: const Icon(Icons.search),
        ),
      ],
    );
  }


}