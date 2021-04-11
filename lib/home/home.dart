import 'package:flutter/material.dart';
import 'package:immo_manager/appbar/appbar.dart';
import 'package:immo_manager/constantes/constants.dart';
import 'package:immo_manager/constantes/transition.dart';
import 'package:immo_manager/drawer/navigationDrawer.dart';
import 'package:immo_manager/experience/location.dart';
import 'package:immo_manager/experience/vente.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DateTime abonne=new DateTime.now();
  DateTime today = new DateTime.now();
  _getAnnonce(){
    annoncesService.getProduit(user[0].id).then((annonce){
      setState(() {
        annonces=annonce;
        filtreAnnonce=annonces;
      });
    } );
  }
  _getAbonnement(){
    annoncesService.getPaiement(user[0].id).then((annonce){
      setState(() {
        filtreAbonne=annonce;
      });
    } );
  }
  verifications(){
    if(filtreAbonne.length!=0) {
      for (int i = 0; i < filtreAbonne.length; i++) {
        abonne= DateTime.parse(filtreAbonne[i].fin);
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAnnonce();
    _getAbonnement();
    verifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  if(today.isAfter(abonne)){
                    SoldeInsuffisant();
                  }else{
                    Navigator.push(context, SlideRightRoute(page: Vente()));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  margin: EdgeInsets.only(top:40.0,left: 60,right: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                            child: Image.asset(
                              'assets/vente.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Vente",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                  if(today.isAfter(abonne)){
                    SoldeInsuffisant();
                  }else{
                    Navigator.push(context, SlideRightRoute(page: Location()));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  margin: EdgeInsets.only(top:40.0,left: 60,right: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/location.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Location",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
  Future<Null> SoldeInsuffisant() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Aucun abonnement",style: TextStyle(color:Colors.red),),
                content: new Text("Vous n'avez aucun abonnement en cours pour faire une publication"),
                contentPadding: EdgeInsets.all(5.0),
                actions: <Widget>[
                  new FlatButton(onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                      child: new Text("OK",style: TextStyle(color: kPrimaryColor),)
                  ),
                ],
              );
            }
        )
    );
  }
}
