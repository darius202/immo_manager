import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immo_manager/constantes/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:immo_manager/authentifications/login.dart';

class ProfilModif extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfilModif();
  }
}

class _ProfilModif extends State<ProfilModif> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController pseudocontroller;
  TextEditingController contact;
  TextEditingController mailcontroller;
  String message = '';

  List <String> preferences=List();
  List <String> provisoire=List();

  String invalide="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pseudocontroller = TextEditingController();
    mailcontroller = TextEditingController();
    contact = TextEditingController();
    user[0].pseudo.isNotEmpty? pseudocontroller.text= user[0].pseudo:pseudocontroller.text="";
    user[0].email.isNotEmpty? mailcontroller.text= user[0].email:mailcontroller.text="";
    user[0].contact.isNotEmpty? contact.text= user[0].contact:contact.text="";
    downloadImage();
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
    } catch (error) {
      print(error);
    }
  }

  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  Future<bool> SavePreferenceemail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }

  Future<bool> SavePreferencepass(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pass", pass);
  }
  File _image;
  String profilePath;
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
  void _onLoading() {
    _handleSubmit(context);
    Usersnotifications.updateCompte(user[0].id, pseudocontroller.text, mailcontroller.text, contact.text).then((value) {
      if('Succès'==value){
        setState(() {
          user[0].pseudo=pseudocontroller.text;
          user[0].email=mailcontroller.text;
          user[0].contact= contact.text;
          SaveEmail();
          Navigator.pop(context);
        });
        Navigator.pop(context);
      }else{
        Navigator.pop(context);
        echec();
      }
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      body: SingleChildScrollView(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key:_formKey,
              child: Column(
                children: [
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
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.1,
                    padding: EdgeInsets.only(left:20.0,right: 20.0),
                    child: TextFormField(
                      controller: pseudocontroller,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText:  "Nom de l'agence ou de l'agent",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                      ),

                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.1,
                    padding: EdgeInsets.only(left:20.0,right: 20.0),
                    child: TextFormField(
                      controller: mailcontroller,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                      ),

                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.1,
                    padding: EdgeInsets.only(left:20.0,right: 20.0),
                    child: TextFormField(
                      controller: contact,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Contact',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                      ),

                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.3,
                    decoration: new BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: FlatButton(
                      onPressed: (){
                        setState(() {
                          message="";
                            _onLoading();
                        });
                      },
                      child: Text("ENREGISTRER",
                        style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Monteserrat"),),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(message,style: TextStyle(color: Colors.red),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<Null> echec() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Erreur",style: TextStyle(color:Colors.red),),
                content: new Text(" Une erreur s'est produite"),
                contentPadding: EdgeInsets.all(5.0),
                actions: <Widget>[
                  new FlatButton(onPressed: () {
                    Navigator.pop(context);
                  },
                      child: new Text("OK",style: TextStyle(color: kPrimaryColor),)
                  ),
                ],
              );
            }
        )
    );
  }

  void SaveEmail() {
    String email= mailcontroller.text;
    SavePreferenceemail(email);
  }
}

class PhoneWidget extends StatefulWidget {
  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  String _selectedCountryCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 45.0,
      margin: const EdgeInsets.all(3.0),
    );
    return Container(
      width: double.infinity,
      margin: new EdgeInsets.only(left: 40.0, bottom: 20.0, right: 40.0),
      color: Colors.white,
      child: new TextFormField(
        key: _formKey2,
        keyboardType: TextInputType.number,
        controller: contactcontroller,
        decoration: new InputDecoration(
            contentPadding: const EdgeInsets.all(14.0),
            fillColor: Colors.white,
            prefixIcon: countryDropDown,
            hintText: ' Numéro',
            hintStyle: TextStyle(color: Colors.grey)
        ),
      ),
    );
  }
}
TextEditingController contactcontroller=TextEditingController();
String contactcode="";
final _formKey2 = GlobalKey<FormState>();

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: kPrimaryColor,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Patientez svp...",style: TextStyle(color: Colors.white),)
                      ]),
                    )
                  ]));
        });
  }
}