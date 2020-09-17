import 'package:flutter/material.dart';
import 'package:immo_manager/constants.dart';
class Connector extends StatefulWidget {

  @override
  _ConnectorState createState() => _ConnectorState();
}

class _ConnectorState extends State<Connector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: kPrimaryColor,),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/wimmo.jpg',
          fit: BoxFit.contain,
          height: 400,
          width: 190,
        ),
        centerTitle: true,
      ),
      body: Scaffold(
        appBar: AppBar(
          title: Text("Page non trouvée"),
          centerTitle: true,
          backgroundColor: Color(0xFF184098),
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height/2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                   },
                  icon: Icon(Icons.refresh,size: 40,),
                ),
                Text("Vérifiez votre connexion et réessayez")
              ],
            )
          ),
        ),
      ),
    );
  }
}
