import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTittle = false, String titleText}) {
  return AppBar(
    title: Text(
      //if (isAppTittle ==true)
     isAppTittle ? titleText : "FlutterShare",
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTittle ? "": 'Signatra',
        fontSize: isAppTittle ? 22.0 : 50.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
