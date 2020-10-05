import 'package:flutter/material.dart';
import 'package:immo_manager/appbar.dart';
import 'package:immo_manager/constants.dart';

class Condition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text("CONDITIONS D'UTILISATION ET MESURES DE CONTRÔLE DE WIMMO MANAGER",
                    style:TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: kTextLigthtColor)),
              ),
              SizedBox(height: 10.0,),
              Center(
                child: Text("L'application WIMMO MANAGER est une plateforme de rencontre entre offreurs et demandeurs des services et produits immobiliers. "
                   " Nous travaillons exclusivement à permettre aux agents immobiliers professionnels et actifs, de rendre leurs offres de Biens À LOUER ou À VENDRE, plus visibles à un grand nombre de potentiels clients."

                    "En tant qu'une application mobile WIMMO Manager n'est ni une agence immobilière, ni une plateforme de propositions de biens et services immobiliers. "
                    "Ainsi donc, l'accès et l'utilisation de notre plateforme de rencontre entre l'offre et la demande en immobilier, sont subordonnées à la lecture et à l'approbation de nos conditions d'utilisation suivantes : ",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 20.0,),
              Center(
                child: Text("A/Conditions d'utilisation",
                    style:TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: kTextLigthtColor)),
              ),
              SizedBox(height: 10.0,),
              Center(
                child: Text("1 - Être un agent immobilier ou une agence immobilière professionnel(le)  et actif(ve), en mesure de poster des biens fiables, À LOUER et/ou À VENDRE. ",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("2 - Être entièrement responsable de toutes les offres mises en ligne sur l'application, ainsi que de toutes les transactions immobilières qui en découleraient.  ",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("3 - Annoncer uniquement des biens immobiliers fiables, dont vous avez l'autorisation contractuelle écrite ou verbale, des propriétaires, bailleurs, vendeurs ou toutes autres personnes ayant la qualité requise pour vous donner une telle autorisation. ",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("4 - Respecter les caractéristiques définies par la plateforme pour la mise en ligne d'une annonce immobilière. ",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("5 - Mettre en ligne les informations exactes concernant les  caractéristiques des biens que vous annoncez sur l'application. ",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("6 - Annoncer uniquement des biens réels et non encore loués, ni vendus durant toute la période de leur mise en ligne.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("7 - Être en mesure d'actualiser en temps réel ses offres sur la plateforme, afin de permettre aux demandeurs d'apprécier uniquement des offres disponibles.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("8 - *Ne jamais mettre en ligne* des biens que vous n'avez pas personnellement visités",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("9 - *Ne jamais mettre en ligne* des biens imaginaires.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("10 - *Ne jamais mettre en ligne* des biens dont vous n'avez personnellement pas l'autorisation contractuelle écrite ou verbale de porter à la connaissance de la clientèle.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("11 - *Ne jamais mettre en ligne* des biens à risque; c'est à dire présentant des défauts de fabrication, d'entretien, ou d'existence légale ou encore dont la position géographique n'est pas sécurisante et pouvant ainsi mettre en danger la vie des personnes qui s'y installeraient ou leur faire perdre des biens ou des ressources.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("12 - *Ne jamais mettre en ligne* des produits et ou services autres que les biens immobiliers À LOUER et/ou À VENDRE.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("13 - S'acquitter des frais de souscription aux services WIMMO qui couvrent une période d'activité immobilière",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 20.0,),
              Center(
                child: Text("B/ MESURES DE CONTRÔLE DE WIMMO MANAGER",
                    style:TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: kTextLigthtColor)),
              ),
              SizedBox(height: 10.0,),
              Center(
                child: Text("Afin de veiller scrupuleusement au respect des conditions d'utilisation de WIMMO MANAGER, et de la rendre très utile et efficace pour la communication des produits et services des agents immobiliers actifs, nous avons mis en place quelques mesures de contrôle qui sont les suivantes : ",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("1 - Toute publication qui ne respectera pas les caractéristiques d'annonces de la plateforme sera systématiquement bloquée ou retirée des annonces par l'administration de l'application.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("2 - Toute publication qui sera signalée et vérifiée comme inexacte (description non conforme à la réalité) par un utilisateur de l'application, entraînera la suspension de son auteur, de tous nos services, pendant une période allant d'une semaine à un mois.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("3 - Toute publication qui sera signalée et vérifiée comme fausse (bien inexistant), par un utilisateur, entraînera une suspension de son auteur, de tous nos services, pendant une période allant de un à 3 mois.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("4 -Toute cessation de publication pendant une période de plus de trois mois, entraînera une rupture des services de l'application, à l'endroit de l'agent immobilier concerné. Toutefois un renouvellement de la souscription est possible au besoin.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("5 - La validation d'accès au service de l'application est subordonnée au paiement de l'intégralité des frais de souscription.",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text("Lu et approuvé",
                    style:TextStyle(fontSize:14,color: kTextLigthtColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
