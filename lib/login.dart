import 'package:flutter/material.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/DataTables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:immo_manager/signin.dart';
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _Login();
  }

}

class _Login extends State<Login> {

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
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Chargement..."),
          ],
        ),
      ),
    );
    Userservices.getUser(mailcontroller.text,passcontroller.text).then((user){
      setState(() {
        _user=user;
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
                 return new DataTables(_user[0]);
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
        appBar: AppBar(
          centerTitle: true,
        backgroundColor: Colors.white,
          title: Text(_titreProgress,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue)),
          leading: Image.asset('assets/wimmo.jpg',fit: BoxFit.contain,),
          actions: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("Créer un compte",style: TextStyle(color: Colors.blueGrey)),
              ),
              onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context){
                        return new Sigin();
                      },
                    )
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: 40, left: 20.0, right: 20.0, bottom: 50.0),
              color: Colors.white70,
              //elevation: 5.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 18.0,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.1,
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                        controller: mailcontroller,
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: 'email',
                          prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
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
                          prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                        )
                    ),
                  ),
                  SizedBox(height: 16.0,),
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
                          _getUser();
                          setState(() {
                          });
                        },
                        child: Text("Connexion",
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
                title: new Text("Compte en attente de validation",style: TextStyle(color:Colors.red),),
                content: new Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Votre compte est en attente de validation, réessayez dans quelques instants..."),
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
