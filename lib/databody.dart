import 'package:flutter/material.dart';
import 'package:immo_manager/Details.dart';
import 'package:immo_manager/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
class DataBody extends StatefulWidget {
  User user;
  DataBody(User user){
    this.user=user;
  }
  @override
  _DataBodyState createState() => _DataBodyState();
}

class _DataBodyState extends State<DataBody> {
  static const String lien = "https://gerestock.com/immo/images/";
  static const String parcelle = "Parcelle";
  static const String villa = "Maison ou Villa";
  static const String appartement = "Appartement";
  static const String bureau = "Bureau ou Boutique";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  _deleteAnnonce(Annonce annonce){
    String image1Path="images/";
    String image2Path="images/";
    String image3Path="images/";
    String image4Path="images/";
    image1Path +=annonce.image1;
    image2Path +=annonce.image2;
    image3Path +=annonce.image3;
    image4Path +=annonce.image4;
    annoncesService.deleteProduit(annonce.id,image1Path,image2Path,image3Path,image4Path).then((result){
      if("Succès" == result){
        _getAnnonce();
      }else{
        _getAnnonce();
      }
    }
    );
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
            setState(() {
              annonces=annonce;
              filtreAnnonce=annonces;
              Navigator.pop(context);
            });
          }
        } );
      });
  }
  String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
      return value;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0,right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10,left: 20.0,right: 10.0,bottom: 20.0),
            child:  TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:kPrimaryColor),
                ),
                prefixIcon: Icon(Icons.search,color:kPrimaryColor,size: 26,),
                hintText: 'Rechercher...',
              ),
              onChanged: (String string){
                setState(() {
                  filtreAnnonce = annonces.where((element) =>
                  (element.type_mandat.toLowerCase().contains(string.toLowerCase()) ||
                      element.prix.toLowerCase().contains(string.toLowerCase()) ||element.type_bien.toLowerCase().contains(string.toLowerCase()) || element.date_inscrit.toLowerCase().contains(string.toLowerCase()))).toList();
                });
              },
            ),
          ),
          filtreAnnonce.length==0 ? Text("Aucune annonce publiée"):  Text("Vous avez ${filtreAnnonce.length} annonce(s) publiée(s)"),
          SizedBox(height: 12,),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top:10.0),
                itemCount:filtreAnnonce.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Details(filtreAnnonce[index],widget.user.id))).then((value) {
                        setState(() {
                          _getAnnonce();
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Card(
                        margin: EdgeInsets.all(3.0),
                        borderOnForeground: true,
                        elevation: 3.0,
                        color: Colors.white,
                        child: Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: <Widget>[
                                        filtreAnnonce[index].image1!=null ?
                                        Image.network(
                                          lien+ filtreAnnonce[index].image1,
                                          width: 100,
                                          height: 100,
                                        ):Container(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height:48,
                                    child: Card(
                                      elevation: 2.0,
                                          color: kPrimaryColor,
                                          child: FlatButton(
                                            child: Text(filtreAnnonce[index].type_mandat,
                                              style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: "Monteserrat"),),
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        filtreAnnonce[index].date_inscrit !=null? "Publié le: "+filtreAnnonce[index].date_inscrit :'Connexion impossible',
                                        style: TextStyle(
                                            color:kPrimaryColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        filtreAnnonce[index].type_bien !=null? filtreAnnonce[index].type_bien :'Connexion impossible',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            color:kPrimaryColor,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  filtreAnnonce[index].type_bien !=parcelle?
                                  SizedBox(height: 8.0,):Container(),
                                  filtreAnnonce[index].type_bien==villa?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset('assets/salon.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbsalon+" salon"),
                                      SizedBox(width: 8.0,),
                                      Image.asset('assets/chambre.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbchambre+" chambre"),
                                    ],
                                  ):Container(),
                                  filtreAnnonce[index].type_bien==appartement?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset('assets/salon.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbsalon+" salon"),
                                      SizedBox(width: 8.0,),
                                      Image.asset('assets/chambre.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbchambre+" chambre"),
                                    ],
                                  ):Container(),
                                  filtreAnnonce[index].type_bien !="Parcelle"?
                                  SizedBox(height: 8.0,):Container(),
                                  filtreAnnonce[index].type_bien==villa?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset('assets/cuisine.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbcuisine+" cuisine"),
                                      SizedBox(width: 8.0,),
                                      Image.asset('assets/bain.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbsalledebain+" douche"),
                                    ],
                                  ):Container(),
                                  SizedBox(height: 8.0,),
                                  filtreAnnonce[index].type_bien==villa?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      filtreAnnonce[index].nbboutique!=null?
                                      Text(filtreAnnonce[index].nbboutique+" Boutique",style:TextStyle(fontSize:12,color:kPrimaryColor)):Container(),
                                      SizedBox(width: 5.0,),
                                      filtreAnnonce[index].nbmagasin!=null?
                                      Text(filtreAnnonce[index].nbmagasin+" Magasin",style:TextStyle(fontSize:12,color:kPrimaryColor)):Container(),
                                      SizedBox(width: 5.0,),
                                      filtreAnnonce[index].nbhall!=null?
                                      Text(filtreAnnonce[index].nbhall+" Hall",style:TextStyle(fontSize:12,color:kPrimaryColor)):Container(),
                                    ],
                                  ):Container(),
                                  filtreAnnonce[index].type_bien==appartement?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset('assets/cuisine.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbcuisine+" cuisine"),
                                      SizedBox(width: 8.0,),
                                      Image.asset('assets/bain.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbsalledebain+" douche"),
                                    ],
                                  ):Container(),
                                  filtreAnnonce[index].type_bien==bureau?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset('assets/bain.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbsalon+" douche"),
                                      SizedBox(width: 8.0,),
                                      Image.asset('assets/chambre.png',fit: BoxFit.cover,),
                                      SizedBox(width: 5.0,),
                                      Text(filtreAnnonce[index].nbchambre+" pièce"),
                                    ],
                                  ):Container(),

                                  SizedBox(height: 8.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        filtreAnnonce[index].prix!=null ?filtreAnnonce[index].prix+" Fcfa ":'Connexion impossible...',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        filtreAnnonce[index].negoce!=null? filtreAnnonce[index].negoce:'Connexion impossible...',
                                        style: TextStyle(
                                            color: kTextLigthtColor,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.delete,color: Colors.red,),
                                        onPressed: (){
                                          alerte(annonces[index]);
                                        }
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
  Future<Null> alerte(Annonce annonce) async{
    return(
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text("Supprimer"),
                content:  Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Voulez vous supprimer cette annonce?"),
                ),
                contentPadding: EdgeInsets.all(5.0),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      new FlatButton(onPressed: (){
                        _deleteAnnonce(annonce);
                        Navigator.pop(context);
                      },
                          child: new Text("Supprimer")
                      ),
                      new FlatButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        child: new Text("Annuler",style: TextStyle(color: Colors.red),),
                      )
                    ],),

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