import 'package:flutter/material.dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/pageValidator.dart';
import 'package:immo_manager/databody.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/suggestion.dart';
class DataTables extends StatefulWidget{
  String title="Mes annonces";
  User user;
  DataTables(User user){
    this.user=user;
  }

  @override
  _DataTables createState()=> new _DataTables();

}

class _DataTables extends State<DataTables>{

  GlobalKey <ScaffoldState> _scaffoldkey;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
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
  Future<void> _handleSubmit(BuildContext context) async {
    try {

      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
    } catch (error) {
      print(error);
    }
  }
  _getAnnonce(){
    if(filtreAnnonce.length==0){
      setState(() {
        _handleSubmit(context);
        annoncesService.getProduit(user[0].id).then((annonce){
          if(annonce.length!=0){
            setState(() {
              annonces=annonce;
              filtreAnnonce=annonces;
              Navigator.pop(context);
            });
          }else{
            Navigator.pop(context);
          }
        } );
      });

    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor,
        elevation: 2.0,
        //centerTitle: true,
        title: Text(_titreProgress,style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold)),
        actions: <Widget>[
          widget.user.admini=="oui"? IconButton(icon: Icon(Icons.notifications,size: 30,),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context){
                        return new Notifications(widget.user);
                      },
                    )
                );
              }) :  Text(""),
        ],
      ),
      body: DataBody(widget.user),
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