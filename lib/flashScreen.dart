import 'Dart:async';
import 'package:flutter/material.Dart';
import 'package:immo_manager/login.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/DataTables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  List <User> _user= List();
  List <String> myPreference= List();
  String _myPreference="preferences";
  void getMyPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_myPreference) != null ) {
      setState(() {
        myPreference = prefs.getStringList(_myPreference);
        _user[0].id=myPreference[0];
        _user[0].pseudo=myPreference[1];
        _user[0].email=myPreference[0];
        _user[0].mot_de_passe=myPreference[1];
        _user[0].pays=myPreference[0];
        _user[0].pseudo=myPreference[1];
        _user[0].id=myPreference[0];
        _user[0].pseudo=myPreference[1];
        _user[0].id=myPreference[0];
        _user[0].pseudo=myPreference[1];

      });
    }
  }
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 8),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          //  height: MediaQuery.of(context).size.height/3,
            child: Container(
              padding: EdgeInsets.only(top:60.0,left: 40.0,right: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset('assets/wimmo.jpg',fit: BoxFit.contain,),
                Text("Afrique Immobilier",style: TextStyle(color: Colors.blueAccent),),
              ],
            ),
            ),
      ),
    );
  }
}
