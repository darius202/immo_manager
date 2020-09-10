import 'dart:io';
import 'package:flutter/material.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';

class AjoutTable extends StatefulWidget{

  User user;
  AjoutTable(User user){
    this.user=user;
  }
  final String title= "Wimmo";

  @override
  _AjoutTable createState()=>_AjoutTable();

}

class _AjoutTable extends State<AjoutTable>{

  GlobalKey <ScaffoldState> _scaffoldkey;

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

  List <Pays> _pays= List();
  String _paysselected="";
  List <Ville> _ville=[];
  String _villeselected="";
  List <Ville> filtreVille= [];

  List <Quartier> _quartier= [];
  List <Quartier> filtreQuartier= [];
  String _quartierselected="";

  List <Mandat> _mandat=[];
  String _mandatselected="";

  List <Etage> _etage=[];
  String _etageselected="";

  String negoceController;
  bool isSwitched;
  bool _isEnable=false;
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery,);

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
    var pickedFile = await picker2.getImage(source: ImageSource.gallery,);

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
    final pickedFile = await picker3.getImage(source: ImageSource.gallery,);

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
    final pickedFile = await picker4.getImage(source: ImageSource.gallery,);

    setState(() {
      _image4 = File(pickedFile.path);
    });
  }
  _getAnnonce(){
    annoncesService.getProduit(widget.user.id).then((annonce){
      setState(() {
        annonces=annonce;
        filtreAnnonce=annonces;
      });
    } );
  }
  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
     child: Container(
       margin:  EdgeInsets.all(30.0),
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
    type_mandatController = textHolder;
    negoceController = textHolder2;
    annoncesService.addProduit(
        widget.user.id,
        widget.user.contact,
        intitule_bienController.text,
        type_bienController.text,
        type_mandatController,
        superficieController.text,
        paysController.text,
        villeController.text,
        quartierController.text,
        descriptionController.text,
        prixController.text,
        negoceController,
        nbetagecontroller.text,
        nbpiececontroller.text,
        nbchambrecontroller.text,
        nbsallebaincontroller.text,
        nbtoilvisiteurcontroller.text,
        nbsallesejourcontroller.text,
        _image1,
        _image2,
        _image3,
        _image4,
        widget.user.pseudo).then((result) {
      if ("Succès" == result) {
        _getAnnonce();
        Navigator.pop(context);
        succes();
        _clearValues();
        setState(() {
          _image1 = null;
          _image2 = null;
          _image3 = null;
          _image4= null;
        });
      }
      else {
        Navigator.pop(context);
        echec("Oups! Nous avons rencontrer un problème, vérifiez votre connexion et réessayez");
      }
    });
  }

  _getMandat(){
    Mandatservices.getMandat().then((value) {
     setState(() {
       _mandat=value;
    });  
    });
  }
  _getEtage(){
    Etageservices.getEtage().then((value) {
      setState(() {
        _etage=value;
    }); 
      print("Etage: ${_etage.length}");
    });
  }

  _getVille(){
    Villeservices.getVille().then((value) {
     setState(() {
        _ville=value;
    }); 
     filtreVille = value;
     });
   }
  _getPays(){
    Paysservices.getPays().then((value) {
     setState(() {
       _pays =value;
    }); 
    });
  }
  _getQuartier(){
    Quartierservices.getQuartier().then((value) {
     setState(() {
         _quartier= value;
    }); 
    filtreQuartier=value;
    print(_quartier.length);
    });
  }

  String _titreProgress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titreProgress = widget.title;
    _scaffoldkey = GlobalKey();
    intitule_bienController = TextEditingController();
    type_bienController = TextEditingController();
    type_mandatController = '';
    superficieController = TextEditingController();
    paysController = TextEditingController();
    villeController = TextEditingController();
    quartierController = TextEditingController();
    descriptionController = TextEditingController();
    prixController =TextEditingController();
    nbetagecontroller = TextEditingController();
    nbpiececontroller = TextEditingController();
    nbchambrecontroller = TextEditingController();
    nbsallebaincontroller = TextEditingController();
    nbtoilvisiteurcontroller = TextEditingController();
    nbsallesejourcontroller = TextEditingController();
    nbsallesejourcontroller.text="";
    negoceController ='';
    isSwitched = false;
    _getVille();
    _getPays();
    _getQuartier();
    _getMandat();
    _getEtage();
    setState(() {
      paysController.text=widget.user.pays;
      villeController.text=widget.user.ville;
      quartierController.text=widget.user.quartier;
    });

  }

  _showProgress(String message){
    setState(() {
      _titreProgress=message;
    });
  }

  _showSnacBar(context, message){
    _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  _addAnnonce(){
    if(intitule_bienController.text.isEmpty ||  type_bienController.text.isEmpty  ||paysController.text.isEmpty
    || villeController.text.isEmpty ||  quartierController.text.isEmpty){
      echec("Les informations du bien sont incomplètes");
    }else {
   // _showProgress("Enregistrement...");
      _onLoading();

    }
  }

  _clearValues(){
    intitule_bienController.text = '' ;
    type_bienController.text = '' ;
    type_mandatController = '' ;
    superficieController.text = '' ;
    paysController.text='';
    villeController.text='';
    quartierController.text='';
    descriptionController.text='';
    prixController.text='';
    negoceController = '' ;
    nbetagecontroller.text="";
    nbpiececontroller.text="";
    nbchambrecontroller.text="";
    nbsallebaincontroller.text="";
    nbtoilvisiteurcontroller.text="";
    nbsallesejourcontroller.text="";
    nbsallesejourcontroller.text="";
  }

  bool switchControl = false;
  String textHolder = 'Vente';

  void toggleSwitch(bool value) {

    if(switchControl == false)
    {
      setState(() {
        switchControl = true;
        textHolder = 'Location';
      });

    }
    else
    {
      setState(() {
        switchControl = false;
        textHolder = 'Vente';
      });
    }
  }

  bool switchControl2 = false;
  String textHolder2 = 'prix négociable';

  void toggleSwitch2(bool value) {

    if(switchControl2 == false)
    {
      setState(() {
        switchControl2 = true;
        textHolder2 = 'prix non négociable';
      });

    }
    else
    {
      setState(() {
        switchControl2 = false;
        textHolder2 = 'prix négociable';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      key: _scaffoldkey,
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
       // backgroundColor: Colors.blue,
       elevation: 0,
        title: Text(_titreProgress,style: TextStyle(color: Colors.white,fontSize: 26),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
       child:Card(
         color: Colors.white,
         elevation: 0,
         margin: EdgeInsets.only(top:8.0,left: 5.0,right: 5.0,bottom: 10.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: <Widget>[
             SizedBox(height: 18.0),
             Text("Informations du Bien(obligatoire)",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.normal),),
             SizedBox(height: 14.0),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 Center(
                   child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:[ Transform.scale(
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

                       Text('$textHolder', style: TextStyle(fontSize: 14,color:  Colors.black),)

                       ]),
                 ),
                 Center(
                   child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:[ Transform.scale(
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

                       Text('$textHolder2', style: TextStyle(fontSize: 14,color:  Colors.black),)
                       ])
                 ),
               ],),
             SizedBox(height: 14.0),
              Container(
                padding: EdgeInsets.only(left:12.0, right: 12.0),
                child: TextField(
                    maxLength: 30,
                    textCapitalization: TextCapitalization.sentences,
                    controller: intitule_bienController,
                    autocorrect: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Intitulé du bien:",
                        hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                    ),
                ),
              ),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child:FormField(
             builder: (FormFieldState state) {
               return InputDecorator(
                 decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                   hintText: "Choisissez un type:",
                 ),
                 isEmpty: _mandatselected == '',
                 child: new DropdownButtonHideUnderline(
                   child:ButtonTheme(
                     alignedDropdown: true,
                     child: DropdownButton(
                       isDense: true,
                       value: _mandatselected.isNotEmpty ? _mandatselected : null,
                       onChanged: (String newValue){
                         setState(() {
                           _mandatselected=newValue;
                           type_bienController.text=newValue;
                         });
                         print(_mandatselected);
                       },
                       items: _mandat.map((Mandat map){
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
             SizedBox(height: 12.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child:TextField(
               controller: prixController,
               keyboardType: TextInputType.number,
               autocorrect: true,
               decoration: InputDecoration(
                 hintText: "Prix du bien:",
                 hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                 // prefixIcon: Icon(Icons.title),
                 filled: true,
                 fillColor: Colors.white,
               )
           ),
         ),
             SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child:  FormField(
             builder: (FormFieldState state) {
               return InputDecorator(
                 decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                   hintText: "Choisissez un pays:",
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
                           paysController.text=_pays[index-1].intitulepays;
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
         SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child: FormField(
             builder: (FormFieldState state) {
               return InputDecorator(
                 decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                   hintText: "Choisissez une ville:",
                 ),
                 isEmpty: _villeselected == "",
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
                             villeController.text = _ville[index-1].intituleville;

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
         SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child: FormField(
             builder: (FormFieldState state) {
               return InputDecorator(
                 decoration: InputDecoration(
                   filled: true,
                   fillColor: Colors.white,
                   hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                   hintText: "Choisissez un quartier:",
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
                             quartierController.text= _quartier[index-1].intitulequartier;
                           }else{
                             _villeselected="";
                           }
                         });
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
         SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child: TextField(
               textCapitalization: TextCapitalization.sentences,
               controller: descriptionController,
               autocorrect: true,
               maxLines: 3,
               decoration: InputDecoration(
                 hintText: "Description du bien:",
                 hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                 filled: true,
                 fillColor: Colors.white,
               )
           ),
         ),
             SizedBox(height: 30.0),
             Text("Caractéristiques du Bien(optionnelle)",style: TextStyle(color: Colors.black,fontSize: 17),),
             SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child:TextField(
               controller: superficieController,
               autocorrect: true,
               keyboardType: TextInputType.number,
               decoration: InputDecoration(
                 hintText: "Superficie en m2:",
                 filled: true,
                 fillColor: Colors.white70,
                 hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
               )
           ),
         ),
         SizedBox(height: 14.0),
             Container(
               padding: EdgeInsets.only(left:12.0, right: 12.0),
               child:FormField(
                 builder: (FormFieldState state) {
                   return InputDecorator(
                     decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.white,
                       hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                       hintText: "Niveau d'étage:",
                     ),
                     isEmpty:  _etageselected =='',
                     child: new DropdownButtonHideUnderline(
                       child:ButtonTheme(
                         alignedDropdown: true,
                         child: DropdownButton(
                           isDense: true,
                           value: _etageselected.isNotEmpty ? _etageselected : null,
                           onChanged: (String newValue){
                             setState(() {
                               _etageselected=newValue;
                               nbetagecontroller.text=newValue;
                             });
                             print(_etageselected);
                           },
                           items: _etage.map((Etage map){
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
         SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child:
           TextField(
               keyboardType: TextInputType.number,
               autocorrect: true,
               controller: nbpiececontroller,
               decoration: InputDecoration(
                 hintText: "Nombre de pièce:",
                 //prefixIcon: Icon(Icons.title),
                 prefixStyle: TextStyle(color: Colors.black),
                 filled: true,
                 fillColor: Colors.white70,
                 hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
               )
           ),
         ),
         SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child: TextField(
               keyboardType: TextInputType.number,
               autocorrect: true,
               controller: nbchambrecontroller,
               decoration: InputDecoration(
                 hintText: "Nombre de chambre:",
                 hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                 //prefixIcon: Icon(Icons.title),
                 prefixStyle: TextStyle(color: Colors.black),
                 filled: true,
                 fillColor: Colors.white,
               )
           ),
         ),
         SizedBox(height: 14.0),
         Container(
           padding: EdgeInsets.only(left:12.0, right: 12.0),
           child:TextField(
               keyboardType: TextInputType.number,
               autocorrect: true,
               controller: nbsallebaincontroller,
               decoration: InputDecoration(
                 hintText: "Nombre de salle de bain:",
                 hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                 prefixStyle: TextStyle(color: Colors.black),
                 filled: true,
                 fillColor: Colors.white70,
               )
           ),
         ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.only(left:12.0, right: 12.0),
          child:  TextField(
              keyboardType: TextInputType.number,
              autocorrect: true,
              controller: nbtoilvisiteurcontroller,
              decoration: InputDecoration(
                hintText: "Nombre de toillettes visiteurs:",
                //prefixIcon: Icon(Icons.title),
                prefixStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
              )
          ),
        ),

        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.only(left:12.0, right: 12.0),
          child: TextField(
              keyboardType: TextInputType.number,
              autocorrect: true,
              controller: nbsallesejourcontroller,
              decoration: InputDecoration(
                hintText: "Nombre de salon:",
                hintStyle: TextStyle(fontStyle: FontStyle.normal,fontSize: 14,color: Colors.black),
                //prefixIcon: Icon(Icons.title),
                prefixStyle: TextStyle(color: Colors.black,),
                filled: true,
                fillColor: Colors.white70,
              )
          ),
        ),
             SizedBox(height: 30.0),
             Text("Images",style: TextStyle(color: Colors.black,fontSize: 17),),
             SizedBox(height: 14.0),
         Center(
           child: _image1 == null
               ? Container(
             margin: EdgeInsets.all(10.0),
             decoration: BoxDecoration(
               color: Colors.white70,
             ),
             padding: EdgeInsets.all(10.0),
             child: Center(child: Text("Image1 du bien",style: TextStyle(color:Colors.red,fontStyle: FontStyle.italic),),),
             width: MediaQuery.of(context).size.width*0.9,
             height:  MediaQuery.of(context).size.width*0.4,
           )
               :Container(
               margin: EdgeInsets.all(10.0),
               decoration: BoxDecoration(
                 color: Colors.white70,
               ),
               padding: EdgeInsets.all(10.0),
               child: Column(
                 children: <Widget>[
                   Image.file(_image1,fit: BoxFit.fitWidth,),
                   SizedBox(height: 14.0,),
                   RaisedButton(
                       color: Colors.red,
                       child: Text("Annuler",style: TextStyle(color: Colors.white),),
                       onPressed: (){
                         setState(() {
                           _image1=null;
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
              child: Icon(Icons.add_a_photo,color:Colors.blue),
            ),
            RaisedButton(
              onPressed: getImageGallery,
              child: Icon(Icons.image,color:Colors.blue),
            ),
          ],
         ),
             SizedBox(height: 18.0),
             Center(
               child: _image2 == null
                   ? Container(
                 margin: EdgeInsets.all(10.0),
                 decoration: BoxDecoration(
                   color: Colors.white70,
                 ),
                 padding: EdgeInsets.all(10.0),
                 child: Center(child: Text("Image2 du bien",style: TextStyle(color:Colors.red,fontStyle: FontStyle.italic),),),
                 width: MediaQuery.of(context).size.width*0.9,
                 height:  MediaQuery.of(context).size.width*0.4,
               )
                   :Container(
                 margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                   padding: EdgeInsets.all(10.0),
                   child: Column(
                     children: <Widget>[
                       Image.file(_image2,fit: BoxFit.fitWidth,),
                       SizedBox(height: 14.0,),
                       RaisedButton(
                           color: Colors.red,
                         child: Text("Annuler",style: TextStyle(color: Colors.white),),
                           onPressed: (){
                         setState(() {
                           _image2=null;
                         });
                       }
                       )
                     ],
                   )
               ),
             ),
             //SizedBox(height: 14.0),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 RaisedButton(
                   onPressed: getImageCamera2,
                   child: Icon(Icons.add_a_photo,color:Colors.blue),
                 ),
                 RaisedButton(
                   onPressed: getImageGallery2,
                   child: Icon(Icons.image,color:Colors.blue),
                 ),
               ],
             ),
             SizedBox(height: 22.0),
             Center(
               child: _image3 == null
                   ? Container(
                 margin: EdgeInsets.all(10.0),
                 decoration: BoxDecoration(
                   color: Colors.white70,
                 ),
                 padding: EdgeInsets.all(10.0),
                 child: Center(child: Text("Image3 du bien",style: TextStyle(color:Colors.red,fontStyle: FontStyle.italic),),),
                 width: MediaQuery.of(context).size.width*0.9,
                 height:  MediaQuery.of(context).size.width*0.4,
               )
                   :Container(
                   margin: EdgeInsets.all(10.0),
                   decoration: BoxDecoration(
                     color: Colors.white70,
                   ),
                   padding: EdgeInsets.all(10.0),
                   child: Column(
                     children: <Widget>[
                       Image.file(_image3,fit: BoxFit.fitWidth,),
                       SizedBox(height: 14.0,),
                       RaisedButton(
                         color: Colors.red,
                           child: Text("Annuler",style: TextStyle(color: Colors.white),),
                           onPressed: (){
                             setState(() {
                               _image3=null;
                             });
                           }
                       )
                     ],
                   )
               ),
             ),
            // SizedBox(height: 14.0),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 RaisedButton(
                   onPressed: getImageCamera3,
                   child: Icon(Icons.add_a_photo,color:Colors.blue),
                 ),
                 RaisedButton(
                   onPressed: getImageGallery3,
                   child: Icon(Icons.image,color:Colors.blue),
                 ),
               ],
             ),

             SizedBox(height: 18.0),
             Center(
               child: _image4 == null
                   ? Container(
                 margin: EdgeInsets.all(10.0),
                 decoration: BoxDecoration(
                   color: Colors.white70,
                 ),
                 padding: EdgeInsets.all(10.0),
                 child: Center(child: Text("Image4 du bien",style: TextStyle(color:Colors.red,fontStyle: FontStyle.italic),),),
                 width: MediaQuery.of(context).size.width*0.9,
                 height:  MediaQuery.of(context).size.width*0.4,
               )
                   :Container(
                   margin: EdgeInsets.all(10.0),
                   decoration: BoxDecoration(
                     color: Colors.white70,
                   ),
                   padding: EdgeInsets.all(10.0),
                   child: Column(
                     children: <Widget>[
                       Image.file(_image4,fit: BoxFit.fitWidth,),
                       SizedBox(height: 14.0,),
                       RaisedButton(
                           color: Colors.red,
                           child: Text("Annuler",style: TextStyle(color: Colors.white),),
                           onPressed: (){
                             setState(() {
                               _image4=null;
                             });
                           }
                       )
                     ],
                   )
               ),
             ),
             //SizedBox(height: 14.0),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 RaisedButton(
                   onPressed: getImageCamera4,
                   child: Icon(Icons.add_a_photo,color:Colors.blue),
                 ),
                 RaisedButton(
                   onPressed: getImageGallery4,
                   child: Icon(Icons.image,color:Colors.blue),
                 ),
               ],
             ),
             SizedBox(height: 68.0),
           ],
         ),
       ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
          backgroundColor: Colors.blue ,
          child: Icon(Icons.check,size: 30,),
          onPressed: (){
            _addAnnonce();
          }
      ),
    );

  }
 void _state(File imagefile ){
    setState(() {
      imagefile=null;
    });
}
  Future<Null> succes() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Succès",style: TextStyle(color:Colors.blue)),
                content: new Text("   Votre annonce a été enregistrée avec succès"),
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
  Future<Null> echec(String erreur) async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Formulaire non valide",style: TextStyle(color:Colors.red),),
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
}

class SwitchWidget extends StatefulWidget {
  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();
}

class SwitchWidgetClass extends State {

  bool switchControl = false;
  var textHolder = 'prix négociable';

  void toggleSwitch(bool value) {

    if(switchControl == false)
    {
      setState(() {
        switchControl = true;
        textHolder = 'prix non négociable';
      });
      print('non-négociable');
      // Put your code here which you want to execute on Switch ON event.

    }
    else
    {
      setState(() {
        switchControl = false;
        textHolder = 'prix négociable';
      });
      print('négociable');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ Transform.scale(
            scale: 1.2,
            child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.red,
              activeTrackColor: Colors.red,
              inactiveThumbColor: Colors.blueAccent,
              inactiveTrackColor: Colors.grey,
            )
        ),
        Text('$textHolder', style: TextStyle(fontSize: 14),)
        ]
    );
  }
}

class SwitchWidget2 extends StatefulWidget {
  @override
  SwitchWidgetClass2 createState() => new SwitchWidgetClass2();
}

class SwitchWidgetClass2 extends State {

  bool switchControl2 = false;
  var textHolder2 = 'Vente';

  void toggleSwitch2(bool value) {

    if(switchControl2 == false)
    {
      setState(() {
        switchControl2 = true;
        textHolder2 = 'Location';
      });
      print('non-négociable');
      // Put your code here which you want to execute on Switch ON event.

    }
    else
    {
      setState(() {
        switchControl2 = false;
        textHolder2 = 'Vente';
      });
      print('négociable');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ Transform.scale(
            scale: 1.2,
            child: Switch(
              onChanged: toggleSwitch2,
              value: switchControl2,
              activeColor: Colors.green,
              activeTrackColor: Colors.red,
              inactiveThumbColor: Colors.teal,
              inactiveTrackColor: Colors.grey,
            )
        ),

        Text('$textHolder2', style: TextStyle(fontSize: 14),)

        ]);
  }
}

