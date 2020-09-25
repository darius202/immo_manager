import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/profitmodif.dart';
import 'package:immo_manager/transition.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  File _image;
  String profilePath;
  @override
  void initState() {
    super.initState();
    downloadImage();  }
  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Select image path' + _image.path.toString());
    });
  }
  Future downloadImage() async {
    if (profilePath != null) {
      var image = new File(profilePath);
      setState(() {
        _image = image;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color:Colors.white,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor,
        title: Text("Mon profil",style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 280.0,
                  width: double.infinity,
                ),
                Container(
                  height: 500.0,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Positioned(
                  top: 125.0,
                  left: 15.0,
                  right: 15.0,
                  child: Material(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                    ),
                    child: Container(
                      height: 230.0,
                      /*  decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(7.0),
                           color: Colors.white),*/
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: (MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 70.0),
                  child: Container(
                    child: new Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: new Stack(
                              fit: StackFit.loose, children: [
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Center(
                                  child: _image == null
                                      ? new Icon(Icons.camera_alt, color: Colors.grey, size: 140,)
                                      : new CircleAvatar(
                                    backgroundImage: new FileImage(_image),
                                    radius: 65.0,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 200.0,
                  left: 15.0,
                  right: 15.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user[0].pseudo,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(user[0].email,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey),
                            )
                          ]),
                      SizedBox(height: 12.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(user[0].contact,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: kPrimaryColor,fontWeight: FontWeight.bold,letterSpacing: 2.0,),
                            )
                          ]),
                      SizedBox(height: 10.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on,color: kPrimaryColor,size: 30,),
                            Text(user[0].quartier.toUpperCase()+" - ",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: kPrimaryColor,fontWeight: FontWeight.bold),
                            ),
                            Text(user[0].ville.toUpperCase()+" - ",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: kPrimaryColor,fontWeight: FontWeight.bold),
                            ),
                            Text(user[0].pays.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: kPrimaryColor,fontWeight: FontWeight.bold),
                            )
                          ]),
                      SizedBox(height: 80.0),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.3,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Card(
                          color: kPrimaryColor,
                          elevation: 5.0,
                          child:  FlatButton(
                            onPressed: (){
                              Navigator.push(context, SlideRightRoute(page: ProfilModif()));
                            },
                            child: Text("ACTUALISER",
                              style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Monteserrat"),),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //TODO HERE CONTEXT ADD
          ],
        ));
  }
  @override
  void dispose() {
    super.dispose();
  }
}