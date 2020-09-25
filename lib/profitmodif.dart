import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:immo_manager/login.dart';

class ProfilModif extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfilModif();
  }
}

class _ProfilModif extends State<ProfilModif> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController pseudocontroller;
  TextEditingController ancienpasscontroller;
  TextEditingController confirmpasscontroller;
  TextEditingController mailcontroller;
  TextEditingController passcontroller;
  TextEditingController payscontroller;
  TextEditingController villecontroller;
  TextEditingController quartiercontroller;
  TextEditingController representantcontroller;
  String message = '';

  List <String> preferences=List();
  List <String> provisoire=List();

  List <Pays> _pays= List();
  String _paysselected="";
  List <Ville> _ville=[];
  String _villeselected="";
  List <Ville> filtreVille= [];
  String invalide="";

  List <Quartier> _quartier= [];
  List <Quartier> filtreQuartier= [];
  String _quartierselected="";


  String _titreProgress="Créer un compte";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pseudocontroller = TextEditingController();
    mailcontroller = TextEditingController();
    passcontroller = TextEditingController();
   ancienpasscontroller = TextEditingController();
    confirmpasscontroller = TextEditingController();
    payscontroller = TextEditingController();
    villecontroller = TextEditingController();
    quartiercontroller = TextEditingController();
    representantcontroller = TextEditingController();
    user[0].pseudo.isNotEmpty? pseudocontroller.text= user[0].pseudo:pseudocontroller.text="";
    user[0].email.isNotEmpty? mailcontroller.text= user[0].email:mailcontroller.text="";
    downloadImage();
    _getVille();
    _getPays();
    _getQuartier();
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
    } catch (error) {
      print(error);
    }
  }

  _getVille(){
    setState(() {
      _ville=ville;
      filtreVille = ville;
    });
  }
  _getPays(){
    setState(() {
      _pays =pays;
    });
  }
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  _getQuartier(){
    setState(() {
      _quartier= quartier;
      filtreQuartier=quartier;
    });
  }

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
    annoncesService.upload(_image).then((value) {
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
                              Padding(
                                  padding: EdgeInsets.only(top: 90.0, left: 90.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new FloatingActionButton(
                                        foregroundColor: Colors.grey,
                                        backgroundColor: Colors.white,
                                        onPressed: getImage,
                                        tooltip: 'Pick Image',
                                        child: Icon(Icons.add_a_photo),
                                      ),
                                    ],
                                  )),
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
                    padding: EdgeInsets.only(top:20.0,left:20.0,right: 20.0),
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
                      controller: ancienpasscontroller,
                      autocorrect: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Ancien mot de passe',
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
                      controller: passcontroller,
                      autocorrect: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Nouveau mot de passe',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
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
                      controller: confirmpasscontroller,
                      autocorrect: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirmer mot de passe',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(left:40.0,right: 40.0),
                    child: FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Pays",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          isEmpty: _paysselected == '',
                          child: new DropdownButtonHideUnderline(
                            child:ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isDense: true,
                                value: _paysselected.isNotEmpty ? _paysselected : null,
                                onChanged: (String newValue){
                                  setState(() {
                                    int index =int.parse(newValue);
                                    payscontroller.text=_pays[index-1].intitulepays;
                                    _paysselected=newValue;
                                    _villeselected ="";
                                    _quartierselected="";
                                    filtreVille = _ville.where((element) =>
                                    (element.codepays.toLowerCase().contains(newValue.toLowerCase()))
                                    ).toList();
                                  });
                                  print(_paysselected);
                                },
                                items: _pays.map((Pays map){
                                  return new DropdownMenuItem(
                                    value: map.codepays,
                                    child: Text(map.intitulepays),
                                  );
                                }
                                ).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(left:40.0,right: 40.0),
                    child: FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Ville",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          isEmpty: _villeselected == '',
                          child: new DropdownButtonHideUnderline(
                            child:ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isDense: true,
                                value: _villeselected.isNotEmpty ? _villeselected : null,
                                onChanged: (String newValue){
                                  setState(() {
                                    if(_paysselected!=""){
                                      _quartierselected ="";
                                      _villeselected=newValue;
                                      int index= int.parse(newValue);
                                      villecontroller.text = _ville[index-1].intituleville;
                                      representantcontroller.text=_ville[index-1].representantId;

                                      filtreQuartier = _quartier.where((element) =>
                                      (element.codeville.toLowerCase().contains(newValue.toLowerCase()))
                                      ).toList();
                                    }else{
                                      _villeselected="";
                                      _quartierselected="";
                                    }

                                  });
                                },
                                items: filtreVille.map((Ville map){
                                  return new DropdownMenuItem(
                                    value: map.codeville,
                                    child: Text(map.intituleville),
                                  );
                                }
                                ).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.1,
                    padding: EdgeInsets.only(left: 20.0,right: 20.0),
                    child: FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Quartier",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          isEmpty: _quartierselected == '',
                          child: new DropdownButtonHideUnderline(
                            child:ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isDense: true,
                                value: _quartierselected.isNotEmpty ? _quartierselected : null,
                                onChanged: (String newValue){
                                  setState(() {
                                    if(_villeselected!=""){
                                      _quartierselected=newValue;
                                      int index=int.parse(newValue);
                                      quartiercontroller.text= _quartier[index-1].intitulequartier;
                                    }else{
                                      _villeselected="";
                                    }
                                  });
                                  print(" Akassato: ${newValue}");
                                },
                                items: filtreQuartier.map((Quartier map){
                                  return new DropdownMenuItem(
                                    value: map.codequartier,
                                    child: Text(map.intitulequartier),
                                  );
                                }
                                ).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  PhoneWidget(),
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
                title: new Text("Félicitations!!!",style: TextStyle(color:kPrimaryColor),),
                content: new Text(" Inscription éffectuée. Connectez vous! "),
                contentPadding: EdgeInsets.all(5.0),
                actions: <Widget>[
                  new FlatButton(onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context){
                            return new Login();
                          },
                        )
                    );
                  },
                      child: new Text("OK",style: TextStyle(color: kPrimaryColor),)
                  ),
                ],
              );
            }
        )
    );
  }

  Future<Null> mailUsed() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Email déjà utilisé, veuillez changer",style: TextStyle(color:Colors.red,fontSize: 16),),
                actions: <Widget>[
                  new FlatButton(onPressed: () {
                    Navigator.pop(context);
                  },
                      child: new Text("OK")
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
  void SavePass() {
    String pass= passcontroller.text;
    SavePreferencepass(pass);
  }
}

class PhoneWidget extends StatefulWidget {
  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  String _selectedCountryCode;
  List<codePays> _countryCodes= List();

  _getCode(){
    setState(() {
      _countryCodes=code;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCode();
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
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            hint: Text("Code",style: TextStyle(fontSize: 14,color: Colors.grey),),
            value: _selectedCountryCode,
            items: _countryCodes.map((codePays value) {
              return new DropdownMenuItem<String>(
                  value: value.code,
                  child: new Text(
                    value.code,
                    style: TextStyle(fontSize: 12.0),
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCountryCode = value;
                contactcode=value;
              });
            },
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
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