import 'package:flutter/material.dart';
import 'package:immo_manager/constants.dart';

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon,size: 28,color: kPrimaryColor,),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text,style: TextStyle(color: kTextLigthtColor,fontSize: 16,fontWeight: FontWeight.bold),),
        )
      ],
    ),
    onTap: onTap,
  );
}