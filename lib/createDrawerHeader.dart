import 'package:flutter/material.dart';
import 'package:immo_manager/constants.dart';

Widget createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.only(top:60.0),
      padding:EdgeInsets.all(60.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image:  AssetImage('assets/icone.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}