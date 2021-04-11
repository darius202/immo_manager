import 'package:flutter/material.dart';
import 'package:immo_manager/constantes/constants.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/services/Services.dart';
import 'package:kkiapay_flutter_sdk/kkiapayWebview.dart';

class Abonnement extends StatefulWidget {
  @override
  AbonnementState createState() => AbonnementState();
}

class AbonnementState extends State<Abonnement> {

  String confirmation;
  DateTime abonne=new DateTime.now();
  DateTime today = new DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController mois;

  verifications(){
    if(filtreAbonne.length!=0) {
      for (int i = 0; i < filtreAbonne.length; i++) {
        abonne= DateTime.parse(filtreAbonne[i].fin);
        print("Voici"+abonne.toString());
      }
      if(today.isAfter(abonne)){

      }else{
        setState(() {
          confirmation="Expire le :"+abonne.day.toString()+"/"+abonne.month.toString()+"/"+abonne.year.toString();
        });
        print(abonne.toString());
      }

    }else{
      print("Rien en vue"+filtreAbonne.length.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confirmation="Pas d'abonnement en cours";
    setState(() {
      verifications();
    });
 mois = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Text(""),
          backgroundColor: kPrimaryColor,
          elevation: 2.0,
        title: Text('Abonnement',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        child: Form(
        key:_formKey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/4.2,),
            Text(paiement[0].montant+"f pour 31 jours",style: TextStyle(color: Colors.red,fontSize: 16),),
            SizedBox(height: 20),
            Text(confirmation,style: TextStyle(color: Colors.red,fontSize: 16),),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top: 10,left: 40.0,right: 40.0,bottom: 20.0),
              child: TextFormField(
                controller: mois,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:kPrimaryColor),
                  ),
                  hintText: "Nombre de mois d'abonnement à éffectuer",
                ),
                validator: (value) {
                  if (value.isEmpty || int.parse(value)<=0) {
                    return 'Entrer un nombre de mois valide';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ButtonTheme(
                minWidth: 250.0,
                height: 60.0,
                child: FlatButton(
                  color: Color(0xFFE30E25),
                  child: Text(
                    'Créditer',
                    style: TextStyle(color: Colors.white,fontSize: 24),
                  ),
                  onPressed: () {
                    if(confirmation!="Pas d'abonnement en cours"){
                      echec();
                    }else {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              KKiaPay(
                                amount: int.parse(paiement[0].montant)*int.parse(mois.text),
                                phone: "",
                                data: 'hello world',
                                sandbox:false,
                                apikey: 'de74e1ab0dbc1a565893296995b8fd5a5b696b43',
                                callback: sucessCallback,
                                name: user[0].pseudo,
                                theme: ("#184098"),
                              )),
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Future<Null> echec() async {
    return (
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text("Abonnement en cours",style: TextStyle(color:Colors.red),),
                content: new Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Vous avez un abonnement en cours déjà"),
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
  Future<void> sucessCallback(response, context) async {
    annoncesService.getPaiement(user[0].id).then((annonce) {
      setState(() {
        filtreAbonne = annonce;
      });
    });
    if (today.isAfter(abonne)) {
      Updatesoldes.updateSolde(user[0].id, today.toString(),
          today.add(Duration(days: 31 * int.parse(mois.text))).toString(),
          paiement[0].montant).then((result) {
        if (result == '1') {
          setState(() {
            Navigator.pop(context);
            abonne = today.add(Duration(days: 31* int.parse(mois.text)));
            confirmation = "Expire le :" + abonne.day.toString() + "/" +
                abonne.month.toString() + "/" + abonne.year.toString();
          });
        }
      });
    } else {
      Updatesoldes.updateSolde(user[0].id, today.toString(),
          abonne.add(Duration(days: 31 * int.parse(mois.text))).toString(),
          paiement[0].montant).then((result) {
        if (result == '1') {
          setState(() {
            Navigator.pop(context);
            abonne = abonne.add(Duration(days: 31* int.parse(mois.text)));
            confirmation = "Expire le :" + abonne.day.toString() + "/" +
                abonne.month.toString() + "/" + abonne.year.toString();
          });
        }
      });
    }
  }
}