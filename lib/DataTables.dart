import 'package:flutter/material.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/AjoutTable.dart';
import 'package:immo_manager/pageValidator.dart';
import 'package:immo_manager/databody.dart';
import 'package:immo_manager/suggestion.dart';
class DataTables extends StatefulWidget{
  String title="Wimmo";
  User user;
  DataTables(User user){
    this.user=user;
  }

  @override
  _DataTables createState()=> new _DataTables();

}

class _DataTables extends State<DataTables>{

  GlobalKey <ScaffoldState> _scaffoldkey;

  TextEditingController intitule_bienController;
  TextEditingController type_bienController;
  TextEditingController type_mandatController;
  TextEditingController superficieController;
  TextEditingController paysController;
  TextEditingController villeController;
  TextEditingController quartierController;
  TextEditingController descriptionController;
  TextEditingController prixController;
  TextEditingController negoceController;

  String _titreProgress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titreProgress = widget.title;
    _scaffoldkey = GlobalKey();
    intitule_bienController = TextEditingController();
    type_bienController = TextEditingController();
    type_mandatController = TextEditingController();
    superficieController = TextEditingController();
    paysController = TextEditingController();
    villeController = TextEditingController();
    quartierController = TextEditingController();
    descriptionController = TextEditingController();
    prixController =TextEditingController();
    negoceController =TextEditingController();
    _getAnnonce();
  }

  _showProgress(String message){
    setState(() {
      _titreProgress=message;
    });
}

  _getAnnonce(){
    _showProgress("Chargement...");
    annoncesService.getProduit(widget.user.id).then((annonce){
      if(annonce.length !=0){
        setState(() {
          annonces=annonce;
          filtreAnnonce=annonces;
          _showProgress(widget.title);
        });
      }
      else{
        _showProgress(widget.title);
      }

      print("Taille ${widget.user.id}");
    } );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 2.0,
        //centerTitle: true,
        title: Text(_titreProgress,style: TextStyle(color: Colors.white,fontSize: 20)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh,),
              onPressed: (){
            _getAnnonce();
              }),
          widget.user.admini=="oui"? IconButton(icon: Icon(Icons.notifications,),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context){
                        return new Notifications(widget.user);
                      },
                    )
                );
              }) :  Text(""),
          FlatButton(
            child:Text("Suggestion",style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context){
                      return new Suggestion();
                    },
                  )
              );
            },
          )
        ],
      ),
      body: DataBody(widget.user),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,size: 30,),
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AjoutTable(widget.user))).then((value) {
              setState(() {
              _getAnnonce();
              });
            });
          }
      ),
    );
  }

}


