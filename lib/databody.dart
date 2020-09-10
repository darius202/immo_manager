import 'package:flutter/material.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/Details.dart';
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
  _getAnnonce(){
    annoncesService.getProduit(widget.user.id).then((annonce){
      setState(() {
        annonces=annonce;
        filtreAnnonce=annonces;
      });
      print("Taille ${widget.user.id}");
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0,right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10,left: 20.0,right: 20.0,bottom: 10.0),
            child:  TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.search,color: Colors.blue,size: 26,),
                hintText: 'Rechercher...',
              ),
              onChanged: (String string){
                setState(() {
                  filtreAnnonce = annonces.where((element) =>
                  (element.intitule_bien.toLowerCase().contains(string.toLowerCase()) ||
                      element.prix.toLowerCase().contains(string.toLowerCase()) || element.date_inscrit.toLowerCase().contains(string.toLowerCase()))).toList();
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
                    child: Card(
                      margin: EdgeInsets.all(3.0),
                      borderOnForeground: true,
                      elevation: 8.0,
                      color: Colors.blueGrey,
                      child: Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  filtreAnnonce[index].intitule_bien !=null? filtreAnnonce[index].intitule_bien :'Connexion impossible',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      filtreAnnonce[index].prix!=null? filtreAnnonce[index].prix:'Connexion impossible...',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.yellowAccent,
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
                                      filtreAnnonce[index].date_inscrit!=null? filtreAnnonce[index].date_inscrit:'Connexion impossible...',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                icon: Icon(Icons.delete,color: Colors.white,),
                                onPressed: (){
                                  alerte(filtreAnnonce[index]);
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
          SizedBox(height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(Icons.person,color: Colors.white,),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 12.0,),
                Text(widget.user.pseudo,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14),),
              ],
            ),)
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

