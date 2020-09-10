import 'package:flutter/material.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/DataTables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:immo_manager/login.dart';

class Sigin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Sigin();
  }
}

class _Sigin extends State<Sigin> {

  TextEditingController pseudocontroller;
  TextEditingController mailcontroller;
  TextEditingController passcontroller;
  TextEditingController contactcontroller;
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
    contactcontroller = TextEditingController();
    payscontroller = TextEditingController();
    villecontroller = TextEditingController();
    quartiercontroller = TextEditingController();
    representantcontroller = TextEditingController();

    _getVille();
    _getPays();
    _getQuartier();
  }


  _getVille(){
    Villeservices.getVille().then((value) {
      _ville=value;
      filtreVille = value;
    });
  }
  _getPays(){
    Paysservices.getPays().then((value) {
      _pays =value;
    });
  }
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  _getQuartier(){
    Quartierservices.getQuartier().then((value) {
      _quartier= value;
      filtreQuartier=value;
      print(_quartier.length);
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

  void _onLoading() {
    if( !mailcontroller.text.contains("@gmail.com",0) ){
      mail("  Veuillez renseigner un email valide svp");
      return;
    }
    else if(pseudocontroller.text.isEmpty){
      mail("  Veuillez renseigner un nom d'utilisateur svp");
      return;
    }
    else if(passcontroller.text.isEmpty){
      mail("  Veuillez choisir un mot de passe svp");
      return;
    }
    else if( payscontroller.text.isEmpty){
      mail("  Veuillez choisir un pays svp");
      return;
    }
    else if( villecontroller.text.isEmpty){
      mail("  Veuillez choisir une ville svp");
      return;
    }
    else if( quartiercontroller.text.isEmpty){
      mail("  Veuillez choisir un quartier svp");
      return;
    }
    else if( contactcontroller.text.isEmpty){
      mail("  Veuillez renseigner un contact WhatsApp svp");
      return;
    }else {
      showDialog(
        context: context,
        barrierDismissible: false,
        child: Container(
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.all(10.0),
          child: new Dialog(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                new Text("Attendez Svp"),
              ],
            ),
          ),
        ),
      );
      Userservices.addUser(
          pseudocontroller.text,
          mailcontroller.text,
          passcontroller.text,
          payscontroller.text,
          villecontroller.text,
          quartiercontroller.text,
          contactcontroller.text,
          representantcontroller.text).then((value) {
        if ("Succès" == value) {
          Navigator.pop(context);
          SavePass();
          SaveEmail();
          echec();
        }
      });
    }
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(_titreProgress,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue)),
        leading: Image.asset('assets/wimmo.jpg',fit: BoxFit.contain,),
        actions: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Se connecter",style: TextStyle(color: Colors.blueGrey)),
            ),
            onTap: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context){
                      return new Login();
                    },
                  )
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
            child:  Container(
              child: Form(
                  key:_formKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: pseudocontroller,
                          autocorrect: true,
                          decoration: InputDecoration(
                            hintText: 'Login',
                            prefixIcon: Icon(Icons.person, color: Colors.blueGrey),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Entrer un nom valid svp';
                            }
                            return null;
                          },
                        ),
                      ),
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
                              hintText: 'email',
                              prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Veuillez saisir votre adresse email';
                            }
                            RegExp regExp = new RegExp(emailPattern);
                            if (!regExp.hasMatch(value)) {
                              return "Veuillez saisir une adresse email valide.";
                            }
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                            controller: passcontroller,
                            autocorrect: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Mot de passe',
                              prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Entrer un mot de passe';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          autocorrect: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Entrer à nouveau votre mot de passe',
                            prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value.isEmpty||value!=passcontroller.text) {
                              return 'Mot de passe incorrecte';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        padding: EdgeInsets.all(20.0),
                        child: FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Choisissez un pays",
                                prefixIcon: Icon(Icons.edit_location, color: Colors.blueGrey),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              isEmpty: _paysselected == '',
                              child: new DropdownButtonHideUnderline(
                                child:ButtonTheme(
                                  alignedDropdown: true,
                                  padding: EdgeInsets.all(10.0),
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
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        padding: EdgeInsets.all(20.0),
                        child: FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Choisissez une ville",
                                prefixIcon: Icon(Icons.location_city, color: Colors.blueGrey),
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

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        padding: EdgeInsets.all(20.0),
                        child: FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Choisissez un quartier",
                                prefixIcon: Icon(Icons.my_location, color: Colors.blueGrey),
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
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                            controller: contactcontroller,
                            keyboardType: TextInputType.number,
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: "+229...",
                              prefixIcon: Icon(Icons.phone, color: Colors.blueGrey),
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          validator: (value) {
                            if (value.isEmpty || value.length<8) {
                              return 'Entrer un numero valid';
                            }
                            return null;
                          },
                        ),
                      ),
                      Card(
                        elevation: 7.0,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.3,
                          decoration: new BoxDecoration(
                            color: Colors.blueGrey,
                            border: new Border.all(color: Colors.white, width: 2.0),
                            borderRadius: new BorderRadius.circular(10.0),),
                          child: FlatButton(
                            onPressed: (){
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  _onLoading();
                                }
                              });
                            },
                            child: Text("Créer mon compte",
                              style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.0,),
                      Text(message,style: TextStyle(color: Colors.red),),
                      SizedBox(height: 95.0,),
                    ],
                  ),
                ),
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
                title: new Text("Succès",style: TextStyle(color:Colors.blue),),
                content: new Text("Votre compte est créer avec succès\n"
                    "Veuillez vous connecter"),
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
                      child: new Text("OK")
                  ),
                ],
              );
            }
        )
    );
  }

  Future<Null> mail(String invalide) async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Invalide",style: TextStyle(color:Colors.red),),
                content: new Text(invalide),
                contentPadding: EdgeInsets.all(5.0),
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
