import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:immo_manager/services/Services.dart';
class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  String message;
  TextEditingController contact;
  void _onLoading() {
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
    if(message==""){
      Navigator.pop(context);
      echec("Message vide", "Ecrivez quelque chose");
      return;
    }
    else {
      SuggestionServices.addSuggestion(message,contact.text).then((value) {
        if("Succès"==value){
          Navigator.pop(context);
          succes();
          Navigator.pop(context);
        }
        else{
          Navigator.pop(context);
          echec("Erreur", "Envoie de méssage échoué");
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message = "";
    contact=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Votre suggestion",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: TextField(
                onChanged: (String text){
                  message=text;
                },
                maxLines: 8,
                decoration: InputDecoration(
                    hintText: "Ecrivez nous ici",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: (){
                        _onLoading();
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white70
                ),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/3),
              alignment: Alignment.bottomLeft,
              child: Center(
                child: TextField(
                  controller: contact,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Votre contact ici",
                      prefixIcon: Icon(Icons.call),
                      filled: true,
                      fillColor: Colors.white70
                  ),
                ),
              ) ,
            ),
          ],
        ),
      ),
    );
  }
  Future<Null> echec(String titre,String erreur) async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text(titre,style: TextStyle(color:Colors.red),),
                content: new Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(erreur),
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
  Future<Null> succes() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Succès",style: TextStyle(color:Colors.blue),),
                content: new Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Votre message est envoyé avec succès"),
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
