import 'package:flutter/material.dart';
import 'package:immo_manager/authentifications/signin.dart';
import 'package:immo_manager/constantes/constants.dart';
import 'package:immo_manager/constantes/transition.dart';
import 'package:immo_manager/home/menu.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _Login();
  }
}

class _Login extends State<Login> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController mailcontroller;
  TextEditingController passcontroller;
  String message = '';
  List <User> _user= List();
  List <String> preferences=List();
  List <String> provisoire=List();
  String _titreProgress="Se connecter";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mailcontroller = TextEditingController();
    passcontroller = TextEditingController();
    GetPreferenceemail().then((String email){
      if(email!=null)
      mailcontroller.text=email;
    });
    GetPreferencepass().then((String pass){
      if(pass!=null)
      passcontroller.text=pass;
    });
  }

  Future<void> _handleSubmit(BuildContext context) async {
    try {

      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
    } catch (error) {
      print(error);
    }
  }

  _showProgress(String message){
    setState(() {
      _titreProgress=message;
    });
  }
  Future<bool> SavePreferenceemail(String email) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString("email", email);
  }

  Future<String> GetPreferenceemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email="";
   email= prefs.getString("email");
    return email;
  }
  Future<bool> SavePreferencepass(String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pass", pass);
  }

  Future<String> GetPreferencepass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass="";
    pass= prefs.getString("pass");
    return pass;
  }
  void _onLoading() {
    _handleSubmit(context);
    Userservices.getUser(mailcontroller.text,passcontroller.text).then((value){
      setState(() {
        _user=value;
        user=value;
      });
      if(user.length==0) {
        Navigator.pop(context);
        setState(() {
          _showProgress("Se connecter");
          message = "Mauvais email ou mot de passe \n vérifiez la connexion internet";
        });
      }
      if(user.length!=0){
        Navigator.pop(context);
        SaveEmail();
        SavePass();
       if(_user[0].actif=="oui"){
         Navigator.of(context).pushReplacement(
             MaterialPageRoute(
               builder: (context){
                 return MyBottomBarWidget();
               },
             )
         );
       }else{
        echec();
       }
      }else{

      }
    } );
  }

  _getUser(){
   _onLoading();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top:60.0,left: 60.0,right: 60.0),
                  child: Image.asset('assets/wimmo.jpg',fit: BoxFit.contain,)
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.1,
                padding: EdgeInsets.only(top:10.0,left: 20,right: 20.0),
                child: TextField(
                    controller: mailcontroller,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                    )
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.1,
                padding: EdgeInsets.all(20.0),
                child: TextField(
                    controller: passcontroller,
                    autocorrect: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                    )
                ),
              ),
              SizedBox(height: 16.0,),
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
                      _getUser();
                    },
                    child: Text("Se connecter",
                      style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Monteserrat"),),
                  ),
                ),
              SizedBox(height: 16.0,),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.3,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: FlatButton(
                  color: Colors.white,
                  onPressed: (){
                    Navigator.pushReplacement(context, SlideRightRoute(page:  Sigin()));
                  },
                  child: Text("S'inscrire",
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),),
                ),
              ),
              SizedBox(height: 14.0,),
              Text(message,style: TextStyle(color: Colors.red),),
              SizedBox(height: 95.0,),
            ],
            )
        ),
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

  Future<Null> echec() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Compte suspendu",style: TextStyle(color:Colors.red),),
                content: new Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Ce compte est bloqué"),
                ),
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
  }


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