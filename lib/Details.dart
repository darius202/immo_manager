import 'package:flutter/material.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Details extends StatefulWidget{
 Annonce annonce;
 String id;
 Details(Annonce annonce,String id){
   this.annonce=annonce;
   this.id;
 }
  @override
  _Details createState()=>_Details();
}

class _Details extends State<Details> {

  String path1 = "https://gerestock.com/immo/images/";
  String path2 = "https://gerestock.com/immo/images/";
  String path3 = "https://gerestock.com/immo/images/";
  String path4 = "https://gerestock.com/immo/images/";
  bool readintitule = true;
  bool readtypebien = true;
  bool readprix = true;
  bool readpays = true;
  bool readville = true;
  bool readquartier = true;
  bool readdesc = true;
  bool readsuperficie = true;
  bool readnbetage = true;
  bool readnbpiece = true;
  bool readbnchambre = true;
  bool readnbbain = true;
  bool readtoil = true;
  bool readsejour = true;
  String _titreProgress = "Détails";

  TextEditingController intitule_bienController;
  TextEditingController type_bienController;
  String type_mandatController;
  TextEditingController superficieController;
  TextEditingController paysController;
  TextEditingController villeController;
  TextEditingController quartierController;
  TextEditingController descriptionController;
  TextEditingController prixController;
  TextEditingController nbetagecontroller;
  TextEditingController nbpiececontroller;
  TextEditingController nbchambrecontroller;
  TextEditingController nbsallebaincontroller;
  TextEditingController nbtoilvisiteurcontroller;
  TextEditingController nbsallesejourcontroller;
  String negoceController;


  File _image1;
  File _image2;
  File _image3;
  File _image4;
  final picker = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  final picker4 = ImagePicker();

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 80);

    setState(() {
      _image1 = File(pickedFile.path);
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image1 = File(pickedFile.path);
    });
  }

  Future getImageCamera2() async {
    final pickedFile = await picker2.getImage(source: ImageSource.camera,imageQuality: 80);

    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

  Future getImageGallery2() async {
    final pickedFile = await picker2.getImage(source: ImageSource.gallery);

    setState(() {
      _image2 = File(pickedFile.path);
    });
  }

  Future getImageCamera3() async {
    final pickedFile = await picker3.getImage(source: ImageSource.camera,imageQuality: 80);

    setState(() {
      _image3 = File(pickedFile.path);
    });
  }

  Future getImageGallery3() async {
    final pickedFile = await picker3.getImage(source: ImageSource.gallery);

    setState(() {
      _image3 = File(pickedFile.path);
    });
  }

  Future getImageCamera4() async {
    final pickedFile = await picker4.getImage(source: ImageSource.camera,imageQuality: 80);

    setState(() {
      _image4 = File(pickedFile.path);
    });
  }

  Future getImageGallery4() async {
    final pickedFile = await picker4.getImage(source: ImageSource.gallery);

    setState(() {
      _image4 = File(pickedFile.path);
    });
  }


  bool switchControl2;

  String textHolder2 = "";

  void toggleSwitch2(bool value) {
    if (switchControl2 == false) {
      setState(() {
        switchControl2 = true;
        textHolder2 = 'prix non négociable';
      });
    }
    else {
      setState(() {
        switchControl2 = false;
        textHolder2 = 'prix négociable';
      });
    }
  }


  bool switchControl = false;
  String textHolder = 'Vente';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Location';
      });
    }
    else {
      setState(() {
        switchControl = false;
        textHolder = 'Vente';
      });
    }
  }
  _getAnnonce(){
    annoncesService.getProduit(widget.id).then((annonce){
      setState(() {
        annonces=annonce;
        filtreAnnonce=annonces;
      });
    } );
  }
  void _onLoading(Annonce annonce, String image1, String image2, String image3,
      String image4) {
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
      annoncesService.updateProduit(
        annonce.id,
        intitule_bienController.text,
        type_bienController.text,
        widget.annonce.type_mandat,
        superficieController.text,
        paysController.text,
        villeController.text,
        quartierController.text,
        descriptionController.text,
        prixController.text,
        widget.annonce.negoce,
        image1,
        image2,
        image3,
        image4,
        _image1,
        _image2,
        _image3,
        _image4,
        widget.annonce.image1,
        widget.annonce.image2,
        widget.annonce.image3,
        widget.annonce.image4,).then((result){
        if ("Succès" == result) {
          setState(() {
            Navigator.pop(context);
            succes();
             _getAnnonce();
          });
        } else {
        Navigator.pop(context);
        echec();
        }
      });
  }
  void initState() {
    // TODO: implement initState
    super.initState();

    intitule_bienController = TextEditingController();
    type_bienController = TextEditingController();
    type_mandatController = '';
    superficieController = TextEditingController();
    paysController = TextEditingController();
    villeController = TextEditingController();
    quartierController = TextEditingController();
    descriptionController = TextEditingController();
    prixController = TextEditingController();
    nbetagecontroller = TextEditingController();
    nbpiececontroller = TextEditingController();
    nbchambrecontroller = TextEditingController();
    nbsallebaincontroller = TextEditingController();
    nbtoilvisiteurcontroller = TextEditingController();
    nbsallesejourcontroller = TextEditingController();
    negoceController = '';
    intitule_bienController.text = widget.annonce.intitule_bien;
    type_bienController.text = widget.annonce.type_bien;
    type_mandatController = widget.annonce.type_mandat;
    superficieController.text = widget.annonce.superficie;
    paysController.text = widget.annonce.pays;
    villeController.text = widget.annonce.ville;
    quartierController.text = widget.annonce.quartier;
    descriptionController.text = widget.annonce.description;
    prixController.text = widget.annonce.prix;
    nbetagecontroller.text = widget.annonce.nbetage;
    nbpiececontroller.text = widget.annonce.nbpiece;
    nbchambrecontroller.text = widget.annonce.nbchambre;
    nbsallebaincontroller.text = widget.annonce.nbsallebain;
    nbtoilvisiteurcontroller.text = widget.annonce.nbtoilvisiteur;
    nbsallesejourcontroller.text = widget.annonce.nbsallesejour;
    negoceController = widget.annonce.negoce;
    path1 += widget.annonce.image1;
    path2 += widget.annonce.image2;
    path3 += widget.annonce.image3;
    path4 += widget.annonce.image4;

    textHolder2 = widget.annonce.negoce;
    if (widget.annonce.negoce == "prix négociable") {
      switchControl2 = false;
    }
    else {
      switchControl2 = true;
    }

    textHolder = widget.annonce.type_mandat;
    if (widget.annonce.type_mandat == "Vente") {
      switchControl = false;
    }
    else {
      switchControl = true;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text(_titreProgress),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 20.0, right: 20),
          padding: EdgeInsets.only(left: 5.0, right: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ Transform.scale(
                            scale: 1.2,
                            child: Switch(
                              onChanged: toggleSwitch,
                              value: switchControl,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.blue,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.red,
                            )
                        ),

                        Text('$textHolder',
                          style: TextStyle(fontSize: 14, color: Colors.black),)

                        ]),
                  ),
                  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                onChanged: toggleSwitch2,
                                value: switchControl2,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.blue,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.red,
                              )
                          ),

                          Text('$textHolder2', style: TextStyle(
                              fontSize: 14, color: Colors.black),)
                          ])
                  ),
                ],
              ),
              TextFormField(
                controller: intitule_bienController,
                readOnly: readintitule,
                style: TextStyle(
                    color: Colors.black, textBaseline: TextBaseline.alphabetic),
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readintitule = false;
                          });
                        }),
                    prefixText: 'Intitulé bien:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
                maxLines: 3,
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: type_bienController,
                readOnly: readtypebien,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixText: 'type de bien:  ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
              ),
              SizedBox(height: 14,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: prixController,
                readOnly: readprix,
                decoration: InputDecoration(

                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readprix = false;
                          });
                        }),
                    prefixText: 'Prix:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: paysController,
                readOnly: true,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixText: 'Pays:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: villeController,
                readOnly: true,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixText: 'Ville:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: quartierController,
                readOnly: readquartier,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixText: 'Quartier:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
              ),
              TextFormField(
                maxLines: 3,
                controller: descriptionController,
                readOnly: readdesc,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readdesc = false;
                          });
                        }),
                    prefixText: 'Description:   ',
                    prefixStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: superficieController,
                readOnly: readsuperficie,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readsuperficie = false;
                          });
                        }),
                    prefixText: 'Superficie en (m2):   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: nbetagecontroller,
                readOnly: readnbetage,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readnbetage = false;
                          });
                        }),
                    prefixText: 'Niveau Etage:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: nbpiececontroller,
                readOnly: readnbpiece,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readnbpiece = false;
                          });
                        }),
                    prefixText: 'Nombre de Pièces:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: nbchambrecontroller,
                readOnly: readbnchambre,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readbnchambre = false;
                          });
                        }),
                    prefixText: 'Nombre de Chambres:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: nbsallebaincontroller,
                readOnly: readnbbain,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readnbbain = false;
                          });
                        }),
                    prefixText: 'Nombre de salles de bain:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: nbtoilvisiteurcontroller,
                readOnly: readtoil,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readtoil = false;
                          });
                        }),
                    prefixText: 'Nombre de toillettes visiteurs:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 14,),
              TextFormField(
                controller: nbsallesejourcontroller,
                readOnly: readsejour,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    suffix: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          setState(() {
                            readsejour = false;
                          });
                        }),
                    prefixText: 'Nombre de salon:   ',
                    prefixStyle: TextStyle(color: Colors.black)
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Flexible(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        child: widget.annonce.image1 == null ? Text(
                            "Aucune image") : Column(
                          children: [
                            Image.network(path1,fit: BoxFit.cover,
                              loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return widget.annonce.image1 ==""? Text("Aucune image"):Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null ?
                                    loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 14,),
                            Center(
                              child: _image1 == null
                                  ? Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                ),
                                //padding: EdgeInsets.all(10.0),
                                child: Center(child: Text("Charger image1",
                                  style: TextStyle(color: Colors.red,
                                      fontStyle: FontStyle.italic),),),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.9,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.4,
                              )
                                  : Container(
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                  ),
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.file(
                                        _image1, fit: BoxFit.fitWidth,),
                                      SizedBox(height: 14.0,),
                                      RaisedButton(
                                          color: Colors.red,
                                          child: Text("Annuler",
                                            style: TextStyle(
                                                color: Colors.white),),
                                          onPressed: () {
                                            setState(() {
                                              _image1 = null;
                                            });
                                          }
                                      )
                                    ],
                                  )
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: getImageCamera,
                                  child: Icon(
                                      Icons.add_a_photo, color: Colors.blue),
                                ),
                                RaisedButton(
                                  onPressed: getImageGallery,
                                  child: Icon(Icons.image, color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 14,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      child: widget.annonce.image2 ==null? Text(
                          "Aucune image") : Column(
                        children: [
                          Image.network(path2,fit: BoxFit.cover,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return widget.annonce.image2 ==""? Text("Aucune image"): Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ?
                                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                          Center(
                            child: _image2 == null
                                ? Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(child: Text("Charger image2",
                                style: TextStyle(color: Colors.red,
                                    fontStyle: FontStyle.italic),),),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.9,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.4,
                            )
                                : Container(
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.file(
                                      _image2, fit: BoxFit.fitWidth,),
                                    SizedBox(height: 14.0,),
                                    RaisedButton(
                                        color: Colors.red,
                                        child: Text("Annuler",
                                          style: TextStyle(
                                              color: Colors.white),),
                                        onPressed: () {
                                          setState(() {
                                            _image2 = null;
                                          });
                                        }
                                    )
                                  ],
                                )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: getImageCamera2,
                                child: Icon(
                                    Icons.add_a_photo, color: Colors.blue),
                              ),
                              RaisedButton(
                                onPressed: getImageGallery2,
                                child: Icon(Icons.image, color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width /1.5,
                      child: widget.annonce.image3 == null ? Text(
                          "Aucune image") :
                      Column(
                        children: [
                          Image.network(path3,fit: BoxFit.cover,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return widget.annonce.image3 ==""? Text("Aucune image"): Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ?
                                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                          Center(
                            child: _image3 == null
                                ? Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(child: Text("Charger image3",
                                style: TextStyle(color: Colors.red,
                                    fontStyle: FontStyle.italic),),),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.9,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.4,
                            )
                                : Container(
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.file(
                                      _image3, fit: BoxFit.fitWidth,),
                                    SizedBox(height: 14.0,),
                                    RaisedButton(
                                        color: Colors.red,
                                        child: Text("Annuler",
                                          style: TextStyle(
                                              color: Colors.white),),
                                        onPressed: () {
                                          setState(() {
                                            _image3 = null;
                                          });
                                        }
                                    )
                                  ],
                                )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: getImageCamera3,
                                child: Icon(
                                    Icons.add_a_photo, color: Colors.blue),
                              ),
                              RaisedButton(
                                onPressed: getImageGallery3,
                                child: Icon(Icons.image, color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width /1.5,
                      child: widget.annonce.image4 == null ? Text(
                          "Aucune image") :
                      Column(
                        children: [
                          Image.network(path4,fit: BoxFit.cover,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return widget.annonce.image4 ==""? Text("Aucune image"): Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ?
                                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),

                          Center(
                            child: _image4 == null
                                ? Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Center(child: Text("Charger image4",
                                style: TextStyle(color: Colors.red,
                                    fontStyle: FontStyle.italic),),),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.9,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.4,
                            )
                                : Container(
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.file(
                                      _image4, fit: BoxFit.fitWidth,),
                                    SizedBox(height: 14.0,),
                                    RaisedButton(
                                        color: Colors.red,
                                        child: Text("Annuler",
                                          style: TextStyle(
                                              color: Colors.white),),
                                        onPressed: () {
                                          setState(() {
                                            _image4 = null;
                                          });
                                        }
                                    )
                                  ],
                                )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: getImageCamera4,
                                child: Icon(
                                    Icons.add_a_photo, color: Colors.blue),
                              ),
                              RaisedButton(
                                onPressed: getImageGallery4,
                                child: Icon(Icons.image, color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          backgroundColor: Colors.blue,
          child: Icon(Icons.check, size: 30,),
          onPressed: () {
            setState(() {
              print("Taille ${path2}");
            });
            alerte();
          }
      ),
    );
  }
  Future<Null> alerte() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Modifications"),
                content: new Text("Voulez vous modifier ?"),
                contentPadding: EdgeInsets.all(5.0),
                actions: <Widget>[
                  new FlatButton(onPressed: () {
                    Navigator.pop(context);
                    String image1 = "images/";
                    String image2 = "images/";
                    String image3 = "images/";
                    String image4 = "images/";
                    if (_image1 != null) {
                      image1 += widget.annonce.image1;
                    }
                    if (_image2 != null) {
                      image2 += widget.annonce.image2;
                    }
                    if (_image3 != null) {
                      image3 += widget.annonce.image3;
                    }
                    if (_image4 != null) {
                      image4 += widget.annonce.image4;
                    }
                    widget.annonce.negoce = textHolder2;
                    widget.annonce.type_mandat = textHolder;
                    _onLoading(widget.annonce, image1, image2, image3,image4);
                  },
                      child: new Text("Valider")
                  ),
                  new FlatButton(onPressed: () {
                    Navigator.pop(context);
                  },
                    child: new Text(
                      "Annuler", style: TextStyle(color: Colors.red),),
                  )
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
                title: new Text("Succès",style: TextStyle(color:Colors.blue)),
                content: new Text("   Modifiactions éffectuées, actualisez pour voir les modifications"),
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
  Future<Null> echec() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Echec",style: TextStyle(color:Colors.red)),
                content: new Text("   L'opération a échouée"),
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