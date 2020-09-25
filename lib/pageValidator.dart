import 'package:flutter/material.dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/DataTables.dart';
class Notifications extends StatefulWidget {
  String title="Notifications";
  User user;
  Notifications(User user){
    this.user=user;
  }

  @override
  _NotificationsState createState() => _NotificationsState();
}


class _NotificationsState extends State<Notifications> {

  List <User> _user= List();
  String _titreProgress;
  void _onLoading() {
    _showProgress("Recherche de compte...");
    Usersnotifications.getUser(widget.user.id).then((user){
      setState(() {
        _user=user;
      });
      if(user.length==0) {
        _showProgress("Notifications");
      }
      if(user.length!=0){
        _showProgress("Notifications");
      }else{

      }
    } );
  }

  Container _dataBody(){
    return Container(
      margin: EdgeInsets.only(left: 10.0,right: 10.0,top:10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: Column(
        children: <Widget>[
          _user.length==0 ? Text("Vous n'avez aucune demande en attente"):  Text("Vous avez ${_user.length} demande en attente"),
          SizedBox(height: 12,),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top:10.0),
                itemCount: _user.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    child: Card(
                      margin: EdgeInsets.all(3.0),
                      borderOnForeground: true,
                      elevation: 2.0,
                      color: Colors.white,
                      child: Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                              Icon(Icons.person,color: kPrimaryColor,size: 36,)
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _user[index].date_inscrit !=null? "Demande le "+ _user[index].date_inscrit :'Connexion impossible',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                                Text(
                                  _user[index].pseudo !=null? _user[index].pseudo :'Connexion impossible',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _user[index].contact!=null? _user[index].contact:'Connexion impossible...',
                                      style: TextStyle(
                                          color: kTextLigthtColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _user[index].quartier !=null? _user[index].quartier+"," :'Connexion impossible',
                                      style: TextStyle(
                                        color: kTextLigthtColor,
                                      ),
                                    ),
                                      SizedBox(width: 5.0,),
                                    Text(
                                      _user[index].ville !=null? _user[index].ville+"-" :'Connexion impossible',
                                      style: TextStyle(
                                        color: kTextLigthtColor,
                                      ),
                                    ),
                                    Text(
                                      _user[index].pays!=null? _user[index].pays:'Connexion impossible...',
                                      style: TextStyle(
                                          color: kTextLigthtColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                         Row(
                           children: [
                             IconButton(
                                 icon: Icon(Icons.clear,color: Colors.red,),
                                 onPressed: (){
                                   Usersnotifications.updateCompte(_user[index].id,"rejeter").then((resultat){
                                     if("Succès"==resultat) {
                                       _onLoading();
                                     }
                                     else{

                                     }
                                   } );
                                 }),
                             IconButton(
                                 icon: Icon(Icons.check,color: Colors.green,), onPressed: (){
                               Usersnotifications.updateCompte(_user[index].id,"oui").then((resultat){
                                 if("Succès"==resultat) {
                                   _onLoading();
                                 }
                                 else{

                                 }
                               } );
                             }),
                           ],
                         )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _onLoading();
    //_titreProgress = widget.title;
  }
  _showProgress(String message){
    setState(() {
      _titreProgress=message;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor,
        elevation: 2.0,
        title:Text(_titreProgress,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: _dataBody()

    );
  }
}
