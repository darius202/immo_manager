import 'Dart:async';
import 'package:flutter/material.Dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/errorconnect.dart';
import 'package:immo_manager/login.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _getMandat(){
    TypeBienservices.getMandat().then((value) {
      setState(() {
        mandat=value;
      });
    });
  }
  _getlouable(){
    Bienservices.getLouer().then((value) {
      setState(() {
        louable=value;
      });
    });
  }

  _getCode(){
    CodePaysservices.getCode().then((value) {
      code=value;
    });
  }
  _getEtage(){
    Etageservices.getEtage().then((value) {
      setState(() {
        etage=value;
      });
    });
  }
  _getVille(){
    Villeservices.getVille().then((value) {
      setState(() {
        ville=value;
      });
    });
  }
  _getPays(){
    Paysservices.getPays().then((value) {
      setState(() {
        pays =value;
      });
    });
  }
  _getQuartier(){
    Quartierservices.getQuartier().then((value) {
      setState(() {
        quartier= value;
      });
    });
  }
  _getSituation(){
    Situationservices.getSituationadmin().then((value) {
      situation=value;
    });
  }
  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }
  route() {
      if (pays.length == 0 || ville.length == 0 || quartier.length == 0 ||
          louable.length == 0 || etage.length == 0 || code.length == 0) {
        Navigator.push(context, SlideRightRoute(page: Connector())).then((
            value) {
          setState(() {
            _getVille();
            _getPays();
            _getQuartier();
            _getMandat();
            _getlouable();
            _getSituation();
            _getEtage();
            _getCode();
            startTime();
          });
        });
      } else
        Navigator.pushReplacement(context, SlideRightRoute(page: Login()));
  }
  @override
  void initState() {
    super.initState();
    _getVille();
    _getPays();
    _getQuartier();
    _getMandat();
    _getlouable();
    _getEtage();
    _getSituation();
    _getCode();
    startTime();
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
                Text("Afrique Immobilier",style: TextStyle(color: kPrimaryColor),),
              ],
            ),
            ),
      ),
    );
  }
}
