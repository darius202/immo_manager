import 'package:flutter/material.dart';
import 'package:immo_manager/appbar.dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/location.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/transition.dart';
import 'package:immo_manager/vente.dart';
import 'package:immo_manager/navigationDrawer.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:navigationDrawer(),
        appBar: buildAppBar(),
        body: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, SlideRightRoute(page: Vente(user[0])));
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
                Navigator.push(context, SlideRightRoute(page: Location(user[0])));
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
        )
    );
  }
}
