import 'package:flutter/material.dart';
import 'package:immo_manager/constantes/constants.dart';
AppBar buildAppBar(){
  return AppBar(
    iconTheme: new IconThemeData(color: kPrimaryColor),
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Image.asset(
      'assets/wimmo.jpg',
      fit: BoxFit.contain,
      height: 400,
      width: 190,
    ),
    centerTitle: true,
  );
}