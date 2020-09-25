import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immo_manager/appbar.dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/home.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/navigationDrawer.dart';
import 'package:immo_manager/photo.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/transition.dart';
import 'dart:io';
class Vente extends StatefulWidget {
  User user;
  Vente(User user){
    this.user=user;
  }
  @override
  _VenteState createState() => _VenteState();
}

class _VenteState extends State<Vente> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  static const String parcelle = "Parcelle";
  static const String villa = "Maison ou Villa";
  static const String appartement = "Appartement";
  static const String bureau = "Bureau ou Boutique";
  //Pays  variables
  List <Pays> _pays = List();
  String _paysselected = "";
  String paysController;
//Ville  variables
  List <Ville> _ville = List();
  String _villeselected = "";
  List <Ville> filtreVille = List();
  String villeController;
  bool tapachat=false;
  //Etage
  List <Etage> _etage = List();
  String _etageselected="";
//Quartier  variables
  List <Quartier> _quartier = List();
  List <Quartier> filtreQuartier = List();
  String _quartierselected = "";
  String quartierController;
//Type de bien variables
  List <Mandat> _mandat = List();
  String _mandatselected = "";
  String type_bienController;

  //Situation administrative variables
  List <Situationadmin> _situation = List();
  String _situationselected = "";

  //Superficie  variables
  String nbetageController="";
  TextEditingController superficieController;
  TextEditingController chambreController;
  // Salon  variables
  TextEditingController salonController;
  //Cuisine  variables
  TextEditingController cuisineController;
  // Salle de bain achat variables
  TextEditingController bainController;
  //Prix variables
  TextEditingController prixController;
  String DescriptifController="";
  //Chambre  variables
  String intituleController="";
  String negoce="";
  String situationadministrativeController="";
  String newconstruire="";
  String dependance="";
  String  garage="";
 String  piscine="";
  String jardin="";
  String toilettevisiteur="";
  String debarras="";
  String compteurperso="";
 String  arrierecours="";
  String balcon="";
  String meuble="";
 String  ascensseur="";

  List<Object> images = List<Object>();
  Future<File> _imageFile;

  List<ImageUploadModel> uploader = List();


  _getMandat() {
    setState(() {
      _mandat = mandat;
    });
  }

  _getSituation(){
    setState(() {
      _situation=situation;
    });
  }

  _getEtage(){
    setState(() {
      _etage=etage;
    });
  }
  _getVille() {
    setState(() {
      _ville = ville;
      filtreVille = _ville;
    });
  }

  _getPays() {
    setState(() {
      _pays = pays;
    });
  }

  _getQuartier() {
    setState(() {
      _quartier = quartier;
      filtreQuartier = _quartier;
    });
  }
  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) =>  Home(),
      )
      );
    } catch (error) {
      print(error);
    }
  }
  ImageUploadModel imageUpload1 = new ImageUploadModel();
  ImageUploadModel imageUpload2 = new ImageUploadModel();
  ImageUploadModel imageUpload3 = new ImageUploadModel();
  ImageUploadModel imageUpload4 = new ImageUploadModel();


  void _onLoading() {
    _handleSubmit(context);
    if(negoce=="")
      negoce="Prix négociable";
    if(type_bienController!=parcelle){
      if(newconstruire!="")
        newconstruire="oui";
      if(dependance!="")
        dependance="oui";
      if(garage!="")
        garage="oui";
      if(piscine!="")
        piscine="oui";
      if(jardin!="")
        jardin="oui";
      if(toilettevisiteur!="")
        toilettevisiteur="oui";
      if(debarras!="")
        debarras="oui";
      if(compteurperso!="")
        compteurperso="oui";
      if(arrierecours!="")
        arrierecours="oui";
      if(balcon!="")
        balcon="oui";
    }
    annoncesService.addProduit(user[0].id,
        user[0].contact,
        intituleController,
        type_bienController,
        "Vente",
        superficieController.text!=null?superficieController.text:"",
        paysController,
        villeController,
        quartierController,
        DescriptifController,
        prixController.text!=null?prixController.text:"",
        negoce,
        situationadministrativeController,
        nbetageController,
        salonController.text!=null?salonController.text:"",
        chambreController.text!=null?chambreController.text:"",
        cuisineController.text!=null?cuisineController.text:"",
        bainController.text!=null?bainController.text:"",
        newconstruire,
        dependance,
        garage,
        piscine,
        jardin,
        toilettevisiteur,
        debarras,
        compteurperso,
        arrierecours,
        balcon,
        meuble,
        ascensseur,
        uploader[0].imageFile,
        uploader[1].imageFile,
        uploader[2].imageFile,
        uploader[3].imageFile,
        user[0].pseudo).then((value) {
      if ("1" == value) {
        Navigator.pop(context);
        reussi();

      }else{
        Navigator.pop(context);
       _showMessageInScaffold2("Annonce non publiée...");
      }
    });
  }
  _initialisation(){
    setState(() {
      negoce="";
      situationadministrativeController="";
      newconstruire="";
      dependance="";
      garage="";
      piscine="";
      jardin="";
      toilettevisiteur="";
      debarras="";
      compteurperso="";
      arrierecours="";
      balcon="";
      meuble="";
      ascensseur="";
      superficieController.text="";
      chambreController.text="";
      salonController.text="";
      cuisineController.text="";
      bainController.text="";
      prixController.text="";
      DescriptifController="";
      nbetageController="";
      situationadministrativeController="";
      uploader[0].imageFile=null;
      uploader[1].imageFile=null;
      uploader[2].imageFile=null;
      uploader[3].imageFile=null;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    superficieController= TextEditingController();
    chambreController = TextEditingController();
    salonController= TextEditingController();
    cuisineController= TextEditingController();
    bainController= TextEditingController();
    prixController= TextEditingController();
    superficieController.text="";
    chambreController.text="";
    salonController.text="";
    cuisineController.text="";
    bainController.text="";
    prixController.text="";
    DescriptifController="";
    nbetageController="";
    intituleController="";

    _getVille();
    _getPays();
    _getQuartier();
    _getMandat();
    _getEtage();
    _getSituation();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      imageUpload1.isUploaded = false;
      imageUpload1.uploading = false;
      imageUpload1.imageFile = null;
      imageUpload1.imageUrl = '';

      imageUpload2.isUploaded = false;
      imageUpload2.uploading = false;
      imageUpload2.imageFile = null;
      imageUpload2.imageUrl = '';

      imageUpload3.isUploaded = false;
      imageUpload3.uploading = false;
      imageUpload3.imageFile = null;
      imageUpload3.imageUrl = '';

      imageUpload4.isUploaded = false;
      imageUpload4.uploading = false;
      imageUpload4.imageFile = null;
      imageUpload4.imageUrl = '';
      uploader.add(imageUpload1);
      uploader.add(imageUpload2);
      uploader.add(imageUpload3);
      uploader.add(imageUpload4);
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:navigationDrawer(),
      appBar: buildAppBar(),
      body:Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text("Vente",style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 28),),
          centerTitle: true,
        ),
        body: _loadScreenachat(),
      ),
    );
  }

  Widget _loadScreenachat() {
    return SingleChildScrollView(
      child:  Form(
        key:_formKey,
        child: Column(
          children: [
            Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              height: 45.0,
              margin: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                      hintText: "Type de bien",
                    ),
                    isEmpty: _mandatselected == '',
                    child: new DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          isDense: true,
                          value: _mandatselected.isNotEmpty
                              ? _mandatselected
                              : null,
                          onChanged: (String newValue) {
                            setState(() {
                              _mandatselected = newValue;
                              type_bienController = newValue;
                              _initialisation();
                            });
                            print("type de bien: "+type_bienController);
                          },
                          items: _mandat.map((Mandat map) {
                            return new DropdownMenuItem(
                              value: map.mandat,
                              child: Text(map.mandat),
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
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              height: 45.0,
              margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Flexible(
                    child: new TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                          hintText: "Intitulé du bien",
                          contentPadding: EdgeInsets.all(10)
                      ),
                      onChanged: (String valeur){
                        setState(() {
                          intituleController=valeur;
                          print("intitulé de bien: "+intituleController);
                        });
                      },
                      validator: (String value){
                        if(value.isEmpty){
                          return "Saisissez l'intitulé du bien.";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              height: 45.0,
              margin: const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                      hintText: "Pays",
                    ),
                    isEmpty: _paysselected == '',
                    child: new DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        //padding: EdgeInsets.all(10.0),
                        child: DropdownButton(
                          isDense: true,
                          value: _paysselected.isNotEmpty ? _paysselected : null,
                          onChanged: (String newValue) {
                            setState(() {
                              int index = int.parse(newValue);
                              paysController = _pays[index - 1].intitulepays;
                              _paysselected = newValue;
                              _villeselected = "";
                              _quartierselected = "";
                              filtreVille = _ville.where((element) =>
                              (element.codepays.toLowerCase().contains(
                                  newValue.toLowerCase()))
                              ).toList();
                            });
                            print("Pays du bien: "+paysController);
                          },
                          items: _pays.map((Pays map) {
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
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              height: 45.0,
              margin: const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                      hintText: "Ville",
                    ),
                    isEmpty: _villeselected == "",
                    child: new DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          isDense: true,
                          value: _villeselected.isNotEmpty
                              ? _villeselected
                              : null,
                          onChanged: (String newValue) {
                            setState(() {
                              if (_paysselected != "") {
                                _quartierselected = "";
                                _villeselected = newValue;
                                int index = int.parse(newValue);
                                villeController = _ville[index - 1].intituleville;
                                filtreQuartier = _quartier.where((element) =>
                                (element.codeville.toLowerCase().contains(
                                    newValue.toLowerCase()))
                                ).toList();
                              } else {
                                _villeselected = "";
                                _quartierselected = "";
                              }
                            });
                            print("ville de bien: "+villeController);
                          },
                          items: filtreVille.map((Ville map) {
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
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              height: 45.0,
              margin: const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                      hintText: "Quartier",
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
                                quartierController= _quartier[index-1].intitulequartier;
                              }else{
                                _villeselected="";
                              }
                            });
                            print("quartier de bien:"+quartierController);
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
            GestureDetector(
              child: Container(
                decoration: new BoxDecoration(
                ),
                height: 45.0,
                margin: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                child: Text("Caractéristiques", style: TextStyle(
                    color: kPrimaryColor, decoration: TextDecoration.underline,fontWeight: FontWeight.bold),),
              ),
              onTap: () {
                setState(() {
                  _mandatselected.isEmpty ? _showMessageInScaffold(
                      "Sélectionnez un type de bien pour voir les options") :
                  tapachat=true;
                });
              },
            ),
            Container(
              child: tapachat== true ?  _loadOptionachat(tapachat):SizedBox(
                height: 1.0,
              ),
            ),
            //PhoneWidget(),
          ],
        ),
      ),
    );
  }

  Widget _loadOptionachat(bool tap) {
    if(tap==true){
      switch (_mandatselected) {
        case parcelle:
          return Column(
            children: [
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                height: 45.0,
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        controller: prixController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Prix",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                            if(value.isEmpty){
                              return "Entrer le Prix";
                            }
                        },
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                          controller: superficieController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Superficie",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Entrer la Superficie ";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding:  const EdgeInsets.only(top:5.0,right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: CheckboxGroup(
                    labels: <String>[
                      "Prix non négociable",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        negoce=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                height: 45.0,
                margin: const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
                child: FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                        hintText: "Situation administrative",
                      ),
                      isEmpty: _situationselected == '',
                      child: new DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            isDense: true,
                            value: _situationselected.isNotEmpty
                                ? _situationselected
                                : null,
                            onChanged: (String newValue) {
                              setState(() {
                                _situationselected = newValue;
                                situationadministrativeController = newValue;
                              });
                              print(_situationselected);
                            },
                            items: _situation.map((Situationadmin map) {
                              return new DropdownMenuItem(
                                value: map.situation,
                                child: Text(map.situation),
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
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: true,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Descriptif",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        onChanged: (String valeur){
                            setState(() {
                              DescriptifController=valeur;
                            });
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Entrer une descrption ";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Photos",style: TextStyle(color:kPrimaryColor,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              buildGridView(),
              SizedBox(height: 10.0,),
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
                    if (_formKey.currentState.validate()) {
                      _onLoading();
                    }
                    setState(() {
                    });
                  },
                  child: Text("PUBLIER",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Monteserrat"),),
                ),
              ),
              SizedBox(height: 100,)
            ],
          );
          break;
        case villa:
          return Column(
            children: [
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                height: 45.0,
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                          controller: prixController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Prix",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Entrer le prix ";
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                          controller: superficieController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Superficie",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Entrer la Superficie ";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding:  const EdgeInsets.only(top:5.0,right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: CheckboxGroup(
                    labels: <String>[
                      "Prix non négociable",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        negoce=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                height: 45.0,
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                          controller: salonController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Salon",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Nombre de salon ";
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                          controller: chambreController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Chambre",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Nombre de chambre ";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                height: 45.0,
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                          controller: cuisineController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Cuisine",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Nombre de cuisine ";
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                          controller: bainController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Salle de bain",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Nombre de salle de bain ";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                height: 45.0,
                margin: const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
                child: FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                        hintText: "Nombre d'étage",
                      ),
                      isEmpty: _etageselected == '',
                      child: new DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            isDense: true,
                            value: _etageselected.isNotEmpty
                                ? _etageselected
                                : null,
                            onChanged: (String newValue) {
                              setState(() {
                                _etageselected = newValue;
                                nbetageController = newValue;
                              });
                              print(_etageselected);
                            },
                            items: _etage.map((Etage map) {
                              return new DropdownMenuItem(
                                value: map.niveau,
                                child: Text(map.niveau),
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
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                height: 45.0,
                margin: const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
                child: FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                        hintText: "Situation administrative",
                      ),
                      isEmpty: _situationselected == '',
                      child: new DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            isDense: true,
                            value: _situationselected.isNotEmpty
                                ? _situationselected
                                : null,
                            onChanged: (String newValue) {
                              setState(() {
                                _situationselected = newValue;
                                situationadministrativeController = newValue;
                              });
                              print(_situationselected);
                            },
                            items: _situation.map((Situationadmin map) {
                              return new DropdownMenuItem(
                                value: map.situation,
                                child: Text(map.situation),
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
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Descriptif",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        onChanged: (String valeur){
                          setState(() {
                            DescriptifController=valeur;
                          });
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Entrez une description ";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text("Photos",style: TextStyle(color:kPrimaryColor,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              buildGridView(),
              SizedBox(height: 20,),
              Text("Autres critères",style: TextStyle(color:kPrimaryColor,fontWeight: FontWeight.bold),),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,

                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Nouvelle construction",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        newconstruire=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,

                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Dépendance/Boyerie",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        dependance=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,

                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Garage",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        garage=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,

                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Piscine",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked){
                      setState(() {
                        piscine=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Jardin",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        jardin=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Toilette visiteur",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked){
                      setState(() {
                        toilettevisiteur=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Débarras",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        debarras=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,

                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Arrière-cours",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked){
                      setState(() {
                        arrierecours=checked.toString();
                      });
                    }
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                padding:  const EdgeInsets.only(right: 40.0, left: 40.0),
                margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                child:CheckboxGroup(
                    labels: <String>[
                      "Terasse/Balcon",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        balcon=checked.toString();
                      });
                    }
                ),
              ),
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
                    if (_formKey.currentState.validate()) {
                      _onLoading();
                    }
                    setState(() {

                    });
                  },
                  child: Text("PUBLIER",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Monteserrat"),),
                ),
              ),
              SizedBox(height: 40,)
            ],
          );
          break;
        default:
          return Container();
      }
    }
  }
  Future<Null> reussi() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Félicitations!!!",style: TextStyle(color:kPrimaryColor),),
                content: new Text("Publication éffétuée"),
                contentPadding: EdgeInsets.all(5.0),
                actions: <Widget>[
                  new FlatButton(onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, SlideRightRoute(page: Home()));
                  },
                      child: new Text("OK",style: TextStyle(color: kPrimaryColor),)
                  ),
                ],
              );
            }
        )
    );
  }
  void _showMessageInScaffold(String message) {
    try {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text(message, style: TextStyle(color: Colors.white,fontSize: 16),),
            duration: Duration(seconds: 2, milliseconds: 500),
          )
      );
    } on Exception catch (e, s) {
      print(s);
    }
  }
  void _showMessageInScaffold2(String message) {
    try {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(message, style: TextStyle(color: Colors.white,fontSize: 16),),
            duration: Duration(seconds: 2, milliseconds: 500),
          )
      );
    } on Exception catch (e, s) {
      print(s);
    }
  }
  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          setState(() {
            uploader[index]=images[index];
          });
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                uploader[index].imageFile !=null ?
                Image.file(
                  uploader[index].imageFile!=null?
                  uploader[index].imageFile:"",
                  width: 300,
                  height: 300,
                ):Container(),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add,color: kPrimaryColor,),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();
    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
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