import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:immo_manager/constantes/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'dart:io';
import 'package:searchable_dropdown/searchable_dropdown.dart';
class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
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
  Ville selectedValue;
  Quartier selectedquartier;
  //Etage
  List <Etage> _etage = List();
  String _etageselected="";
  TextEditingController nbetageController;
//Quartier  variables
  List <Quartier> _quartier = List();
  List <Quartier> filtreQuartier = List();
  String _quartierselected = "";
  String quartierController;
//Type de bien variables
  List <Bienlouable> _mandat = List();
  String _mandatselected = "";
  String type_bienController;
  //Superficie  variables
  String superficieController="";
  String DescriptifController;
  //Chambre  variables
  TextEditingController chambreController;
  // Salon  variables
  TextEditingController salonController;
  //Cuisine  variables
  TextEditingController cuisineController;
  TextEditingController boutiqueController;
  TextEditingController magasinController;
  TextEditingController hallController;
  // Salle de bain achat variables
  TextEditingController bainController;
  //Prix variables
  TextEditingController prixController;

  String intituleController;

  List<Object> images = List<Object>();
  Future<File> _imageFile;
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
  final _formKey = GlobalKey<FormState>();
  List<ImageUploadModel> uploader = List();
  String confirmation;
  _getMandat() {
    setState(() {
      _mandat = louable;
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
  ImageUploadModel imageUpload1 = new ImageUploadModel();
  ImageUploadModel imageUpload2 = new ImageUploadModel();
  ImageUploadModel imageUpload3 = new ImageUploadModel();
  ImageUploadModel imageUpload4 = new ImageUploadModel();

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
    } catch (error) {
      print(error);
    }
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
   superficieController="";
   chambreController.text="";
   salonController.text="";
   cuisineController.text="";
   bainController.text="";
   prixController.text="";
   DescriptifController="";
   nbetageController.text="";
   uploader[0].imageFile=null;
   uploader[1].imageFile=null;
   uploader[2].imageFile=null;
   uploader[3].imageFile=null;
   _villeselected="";
   _paysselected="";
    });
 }

  void _onLoading() {
    _handleSubmit(context);
    if(negoce=="" || negoce=="[]")
      negoce="Prix négociable";
    if(newconstruire!="")
      newconstruire="oui";
    if(garage!="")
      garage="oui";
    if(debarras!="")
      debarras="oui";
    if(toilettevisiteur!="")
      toilettevisiteur="oui";
    if(type_bienController==villa){
      if(dependance!="")
        dependance="oui";
      if(piscine!="")
        piscine="oui";
      if(jardin!="")
        jardin="oui";
      if(arrierecours!="")
        arrierecours="oui";
      if(balcon!="")
        balcon="oui";
    }
    if(type_bienController==bureau){
      if(compteurperso!="")
        compteurperso="oui";
      if(ascensseur!="")
        ascensseur="oui";
    }
    if(type_bienController==appartement){
      if(compteurperso!="")
        compteurperso="oui";
      if(arrierecours!="")
        arrierecours="oui";
      if(balcon!="")
        balcon="oui";
      if(ascensseur!="")
        ascensseur="oui";
      if(meuble!="")
        meuble="oui";
    }
    annoncesService.addProduit(user[0].id,
       user[0].contact,
        user[0].pseudo,
        intituleController,
        type_bienController,
        "Location",
        superficieController,
        paysController,
        villeController,
        quartierController,
        DescriptifController,
        prixController.text,
        negoce,
        situationadministrativeController,
        nbetageController.text,
        salonController.text,
        chambreController.text,
        cuisineController.text,
        boutiqueController.text,
        magasinController.text,
        hallController.text,
        bainController.text,
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
      if ( value=='1') {
        setState(() {
          Navigator.pop(context);
          _initialisation();
          reussi();
        });
      }else{
        Navigator.pop(context);
        _showMessageInScaffold2("Annonce non plubliée");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chambreController = TextEditingController();
    salonController= TextEditingController();
    cuisineController= TextEditingController();
    boutiqueController=TextEditingController();
    magasinController=TextEditingController();
    hallController=TextEditingController();
    bainController= TextEditingController();
    prixController= TextEditingController();
    DescriptifController="";
    nbetageController=TextEditingController();
    intituleController="";
    boutiqueController.text="";
    magasinController.text="";
    hallController.text="";
    superficieController="";
    chambreController.text="";
    salonController.text="";
    cuisineController.text="";
    bainController.text="";
    prixController.text="";
    DescriptifController="";
    nbetageController.text="";
    intituleController="";
    _getVille();
    _getPays();
    _getQuartier();
    _getMandat();
    _getEtage();
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
  initiApresenvoie(){
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
    superficieController="";
    chambreController.text="";
    salonController.text="";
    cuisineController.text="";
    bainController.text="";
    prixController.text="";
    DescriptifController="";
    nbetageController.text="";
    uploader[0].imageFile=null;
    uploader[1].imageFile=null;
    uploader[2].imageFile=null;
    uploader[3].imageFile=null;
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
        iconTheme: new IconThemeData(color: kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image.asset(
          'assets/wimmo.jpg',
          fit: BoxFit.contain,
          height: 400,
          width: 190,
        ),
        centerTitle: true,
      ),
      body:Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text("Location",style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 28),),
          centerTitle: true,
        ),
        body: _loadScreenachat(),
      ),
    );
  }

  Widget _loadScreenachat() {
    return SingleChildScrollView(
        child:Form(
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
                        },
                        items: _mandat.map((Bienlouable map) {
                          return new DropdownMenuItem(
                            value: map.bien,
                            child: Text(map.bien),
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
                    onChanged:(String valeur){
                      setState(() {
                        intituleController=valeur;
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
                            _pays = pays.where((element) =>
                            (element.codepays==newValue)).toList();
                            paysController = _pays[0].intitulepays;
                            _paysselected = newValue;
                            filtreVille = _ville.where((element) =>
                            (element.codepays.toLowerCase().contains(
                                newValue.toLowerCase()))
                            ).toList();
                          });
                        },
                        items: pays.map((Pays map) {
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
            padding: EdgeInsets.only(top:10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Flexible(
                  child: new   SearchableDropdown(
                    hint: Text('Ville'),
                    items: filtreVille.map((item) {
                      return new DropdownMenuItem<Ville>(
                          child: Text(item.intituleville), value: item);
                    }).toList(),
                    isExpanded: true,
                    value: selectedValue,
                    isCaseSensitiveSearch: true,
                    searchHint: new Text(
                      'Selectionnez une ville ',
                      style: new TextStyle(fontSize: 20),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                        villeController=selectedValue.intituleville;
                        filtreQuartier = _quartier.where((element) =>
                        (element.codeville.toLowerCase().contains(
                            selectedValue.codeville.toLowerCase()))
                        ).toList();
                      });
                    },
                  ),
                ),
                SizedBox(width: 20.0,),
                new Flexible(
                  child: new  SearchableDropdown(
                    hint: Text('Quartier'),
                    items: filtreQuartier.map((item) {
                      return new DropdownMenuItem<Quartier>(
                          child: Text(item.intitulequartier), value: item);
                    }).toList(),
                    isExpanded: true,
                    value: selectedquartier,
                    isCaseSensitiveSearch: true,
                    searchHint: new Text(
                      'Selectionnez un quartier ',
                      style: new TextStyle(fontSize: 20),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedquartier = value;
                        quartierController=selectedquartier.intitulequartier;
                      });
                    },
                  ),
                ),
              ],
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
        case appartement:
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
                        validator: (String value){
                          if(value.isEmpty){
                            return "Entrez le prix";
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Superficie",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        onChanged: (String valeur){
                            setState(() {
                              superficieController=valeur;
                            });
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
                        hintText: "Niveau",
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
                                nbetageController.text = newValue;
                              });
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
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Descriptif",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        onChanged:(String valeur){
                            setState(() {
                              DescriptifController=valeur;
                            });
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
                      "Compteur personnel",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked)  {
                      setState(() {
                        compteurperso=checked.toString();
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
                    onSelected: (List<String> checked)  {
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
                      "Toilette visiteur",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked)  {
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
                    onSelected: (List<String> checked)  {
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
                    onSelected: (List<String> checked)  {
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
                    onSelected: (List<String> checked)  {
                      setState(() {
                        balcon=checked.toString();
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
                      "Ascensseur",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        ascensseur=checked.toString();
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
                      "Meublé",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked)  {
                      setState(() {
                        meuble=checked.toString();
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
                  },
                  child: Text("PUBLIER",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Monteserrat"),),
                ),
              ),
              SizedBox(height: 40,)
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
                        validator: (String value){
                          if(value.isEmpty){
                            return "Entrez le prix";
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Superficie",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        onChanged: (String valeur){
                          setState(() {
                            superficieController=valeur;
                          });
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
                        controller: boutiqueController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                            hintText: "Boutique",
                            contentPadding: EdgeInsets.all(10)
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                        controller: magasinController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                            hintText: "Magasin",
                            contentPadding: EdgeInsets.all(10)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                height: 45.0,
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 40.0,),
                    new Flexible(
                      child: new TextFormField(
                        controller: hallController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                            hintText: "Hall",
                            contentPadding: EdgeInsets.all(10)
                        ),
                      ),
                    ),
                    SizedBox(width: 40.0,),
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
                                nbetageController.text = newValue;
                              });
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
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Descriptif",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        onChanged:(String valeur){
                          setState(() {
                            DescriptifController=valeur;
                          });
                        },
                        validator: (String value){
                          if(value.isEmpty){
                            return "Entrez une description du bien";
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
                    onSelected: (List<String> checked)  {
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
                    onSelected: (List<String> checked)  {
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
                    onSelected: (List<String> checked)  {
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
                    onSelected: (List<String> checked)  {
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
                    onSelected: (List<String> checked) {
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
                  },
                  child: Text("PUBLIER",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Monteserrat"),),
                ),
              ),
              SizedBox(height: 40,)
            ],
          );
          break;
        case bureau:
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
                        validator: (String value){
                          if(value.isEmpty){
                            return "Entrez le prix";
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    new Flexible(
                      child: new TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Superficie",
                              contentPadding: EdgeInsets.all(10)
                          ),
                        onChanged: (String valeur){
                          setState(() {
                            superficieController=valeur;
                          });
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
                          controller: chambreController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.normal,color: kTextLigthtColor),
                              hintText: "Nombre de pièce",
                              contentPadding: EdgeInsets.all(10)
                          ),
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
                                nbetageController.text = newValue;
                              });
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
                margin: const EdgeInsets.only(top:5.0,right: 20.0, left: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: true,
                          maxLines: null,
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
                        validator: (String value){
                          if(value.isEmpty){
                            return "Entrez une description du bien";
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
                padding:  const EdgeInsets.only(top:20.0,right: 40.0, left: 40.0),
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
                      "Compteur personnel",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        compteurperso=checked.toString();
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
                      "Toilette visiteur",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
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
                      "Ascensseur",
                    ],labelStyle: TextStyle(color: kTextLigthtColor,fontSize: 15),
                    onSelected: (List<String> checked) {
                      setState(() {
                        ascensseur=checked.toString();
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
                    setState(() {
                      Navigator.pop(context);
                      initiApresenvoie();
                    });
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
  void _showMessageInScaffold(String message) {
    try {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text(message, style: TextStyle(color: Colors.white),),
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
      physics: new NeverScrollableScrollPhysics(),
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
                  uploader[index].imageFile,
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
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 20);
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