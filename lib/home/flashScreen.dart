import 'Dart:async';
import 'package:flutter/material.Dart';
import 'package:immo_manager/constantes/constants.dart';
import 'package:immo_manager/constantes/errorconnect.dart';
import 'package:immo_manager/authentifications/login.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/constantes/transition.dart';

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

  _getSolde(){
    SoldeServices.getSolde().then((value) {
      paiement=value;
    });
  }
  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }
  route() {
      if (pays.length == 0 || ville.length == 0 || quartier.length == 0 ||
          louable.length == 0 || etage.length == 0 || paiement.length == 0) {
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
      _getSituation();
    _getSolde();
      _getEtage();
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
