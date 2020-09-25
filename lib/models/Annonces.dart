class Annonce{
  String id;
  String idadmin;
  String admincontact;
  String intitule_bien;
  String type_bien;
  String type_mandat;
  String superficie;
  String pays;
  String ville;
  String quartier;
  String description;
  String prix;
  String negoce;
  String situationadministrative;
  String nbetage;
  String nbsalon;
  String nbchambre;
  String nbcuisine;
  String nbsalledebain;
  String newconstruire;
  String dependance;
  String garage;
  String piscine;
  String jardin;
  String toilettevisiteur;
  String 	debarras;
  String compteurperso;
  String arrierecours;
  String 	balcon;
  String meuble;
  String ascensseur;
  String image1;
  String image2;
  String image3;
  String image4;
  String date_inscrit;

  Annonce({this.id,this.idadmin,this.admincontact,this.intitule_bien,this.type_bien,this.type_mandat,this.superficie,this.pays,this.ville,this.quartier,
    this.description,this.prix,this.negoce,this.situationadministrative,this.nbetage,this.nbsalon,this.nbchambre,this.nbcuisine,this.nbsalledebain,this.newconstruire,
    this.dependance,this.garage,this.piscine,this.jardin,this.toilettevisiteur,this.debarras,this.compteurperso,this.arrierecours,this.balcon,this.meuble,this.ascensseur, this.image1,this.image2,this.image3,this.image4,this.date_inscrit});

  factory Annonce.fromJson(Map<String, dynamic> json){
    return Annonce(
      id:json['id'] as String,
      idadmin:json['idadmin'] as String,
      admincontact:json['admincontact'] as String,
      intitule_bien: json['intitule_bien'] as String,
      type_bien: json['type_bien'] as String,
      type_mandat: json['type_mandat'] as String,
      superficie: json['superficie'] as String,
      pays: json['pays'] as String,
      ville:  json['ville'] as String,
      quartier:  json['quartier'] as String,
      description: json['description'] as String,
      prix: json['prix'] as String,
      negoce: json['negoce'] as String,
      situationadministrative: json['situationadministrative'] as String,
      nbetage: json['nbetage'] as String,
      nbsalon: json['nbsalon'] as String,
      nbchambre: json['nbchambre'] as String,
      nbcuisine: json['nbcuisine'] as String,
      nbsalledebain: json['nbsalledebain'] as String,
      newconstruire: json['newconstruire'] as String,
      dependance: json['dependance'] as String,
      garage: json['garage'] as String,
      piscine: json['piscine'] as String,
      jardin: json['jardin'] as String,
      toilettevisiteur: json['toilettevisiteur'] as String,
      debarras: json['debarras'] as String,
      compteurperso: json['compteurperso'] as String,
      arrierecours: json['arrierecours'] as String,
      balcon: json['balcon'] as String,
      meuble: json['meuble'] as String,
      ascensseur: json['ascensseur'] as String,
      image1:json['image1'] as String,
      image2:json['image2'] as String,
      image3:json['image3'] as String,
      image4:json['image4'] as String,
      date_inscrit:json['date_inscrit'] as String,
    );
  }

}

List <Annonce> annonces= List();
List <Annonce> filtreAnnonce= List();
class User{
  String id;
  String pseudo="";
  String email;
  String mot_de_passe;
  String pays;
  String ville;
  String quartier;
  String contact;
  String admini;
  String actif;
  String representantId;
  String date_inscrit;

  User({this.id,this.pseudo,this.email,this.mot_de_passe,this.pays,this.ville,this.quartier,this.contact,this.admini,this.actif,this.representantId,this.date_inscrit});
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id:json['id'] as String,
      pseudo:json['pseudo'] as String,
      email: json['email'] as String,
      mot_de_passe: json['mot_de_passe'] as String,
      pays: json['pays'] as String,
      ville:json['ville'] as String,
      quartier: json['quartier'] as String,
      contact: json['contact'] as String,
      admini: json['admini'] as String,
      actif: json['actif'] as String,
        representantId:json['representantId'] as String,
        date_inscrit:json['date_inscrit'] as String
    );
  }
}


class Ville{
  String codeville;
  String codepays;
  String intituleville;
  String representantId;
  Ville({this.codeville,this.codepays,this.intituleville,this.representantId});
  factory Ville.fromJson(Map<String, dynamic> json){
    return Ville(
      codeville:json['codeville'] as String,
      codepays:json['codepays'] as String,
      intituleville:json['intituleville'] as String,
      representantId: json['representantId'] as String,
    );
  }
}

class codePays{
  String id;
  String idPays;
  String code;
  codePays({this.id,this.idPays,this.code});
  factory codePays.fromJson(Map<String, dynamic> json){
    return codePays(
      id:json['id'] as String,
      idPays:json['idPays'] as String,
      code:json['code'] as String,
    );
  }
}
class Quartier{

  String  codequartier;
  String codeville;
  String codepays;
  String intitulequartier;

  Quartier({this.codequartier,this.codeville,this.codepays,this.intitulequartier});
  factory Quartier.fromJson(Map<String, dynamic> json){
    return Quartier(
      codequartier:json['codequartier'] as String,
      codeville:json['codeville'] as String,
      codepays:json['codepays'] as String,
      intitulequartier:json['intitulequartier'] as String,
    );
  }
}

class Pays {
  String codepays;
  String intitulepays;

  Pays({this.codepays, this.intitulepays});

  factory Pays.fromJson(Map<String, dynamic> json) {
    return Pays(
      codepays: json['codepays'] as String,
      intitulepays: json['intitulepays'] as String,
    );
  }
}

class Mandat {
String id;
String mandat;

Mandat({this.id, this.mandat});

factory Mandat.fromJson(Map<String, dynamic> json) {
return Mandat(
  id: json['id'] as String,
  mandat: json['mandat'] as String,
);
}
}

class Etage{
  String id;
  String niveau;
  Etage({this.id,this.niveau});
  factory Etage.fromJson(Map<String, dynamic> json) {
    return Etage(
      id: json['id'] as String,
      niveau: json['niveau'] as String,
    );
  }
}
class Bienlouable {
  String id;
  String bien;

  Bienlouable({this.id, this.bien});

  factory Bienlouable.fromJson(Map<String, dynamic> json) {
    return Bienlouable(
      id: json['id'] as String,
      bien: json['bien'] as String,
    );
  }
}

class Situationadmin {
  String id;
  String situation;

  Situationadmin({this.id, this.situation});

  factory Situationadmin.fromJson(Map<String, dynamic> json) {
    return Situationadmin(
      id: json['id'] as String,
      situation: json['situation'] as String,
    );
  }
}

List <Situationadmin> situation= List();
List <User> user= List();
List <Pays> pays;
List <Ville> ville;
List <Quartier> quartier;
List <Mandat> mandat;
List <Etage> etage;
List <codePays> code;
List <Bienlouable> louable;