import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:immo_manager/models/Annonces.dart';
// ignore: camel_case_types
class annoncesService{
  static const ROOT ='https://gerestock.com/immo/annonceRequetes.php';
  static const ROOTIMAGE ='https://gerestock.com/immo/uploadimage.php';
  static const _GET_ALL_ACTION= 'GET_ALL';
  static const _ADD_PROD_ACTION= 'ADD_PROD';
  static const _UPDATE_PROD_ACTION= 'UPDATE_PROD';
  static const _DELETE_PROD_ACTION= 'DELETE_PROD';

//GET DE TOUS LES PRODUITS
  static Future<List<Annonce>> getProduit(String idadmin) async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_ALL_ACTION;
      map['idadmin']= idadmin;
      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getProduit : ${response.body}');
      if(200 == response.statusCode){
        List<Annonce> list = parseResponse(response.body);
        return list;
      }else{
        return List<Annonce>();
      }
    }
    catch(e){

      return List<Annonce>();
    }
  }
  static List<Annonce> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Annonce>((json) => Annonce.fromJson(json)).toList();
  }
//User

  //AJOUT DE PRODUITS A LA BASE DE DONNEES
  static Future<String> addProduit(String idadmin, String admincontact,String adminpseudo,String intitule_bien, String type_bien,String type_mandat,String superficie,String pays,
      String ville,String quartier,String description, String prix, String negoce,String situationadministrative,String nbetage,String nbsalon,String nbchambre,
      String nbcuisine,String  nbboutique,String nbmagasin,String nbhall ,nbsalledebain,String newconstruire,
     String dependance,String garage,String piscine,String jardin, String toilettevisiteur,String debarras,String compteurperso,String arrierecours,String balcon,String meuble,String ascensseur,
      File imageFile,File imageFile2,File imageFile3,File imageFile4,String user ) async{
    try{
      String nom1="";
      String nom2="";
      String nom3="";
      String nom4="";

      if(imageFile !=null) {
        var stream = new http.ByteStream(imageFile.openRead());
        stream.cast();
        var length = await imageFile.length();
        nom1 = imageFile.path.substring(46);
        if(nom1.contains("image_picker",0)){

        }else{
          nom1 = nom1.substring(29);
        }
        user += "/";
        user += imageFile.path.substring(46);
        var uri = Uri.parse(ROOTIMAGE);
        var request = new http.MultipartRequest("POST", uri);
        var multipartFile1 = new http.MultipartFile(
            "image", stream, length, filename: basename(user));
        request.files.add(multipartFile1);
        var response = await request.send();
        if (response.statusCode == 200) {
          print("Image téléchargé");
        } else {
          print("Echec de téléchargement");
        }
      }

      if(imageFile2 !=null) {
        var stream2 = new http.ByteStream(imageFile2.openRead());
        stream2.cast();
        var length2 = await imageFile2.length();
        String user2 = user;
        user2 += "/";
         nom2  = imageFile2.path.substring(46);
        if(nom2.contains("image_picker",0)){

        }else{
          nom2 = nom2.substring(29);
        }
        user2 += imageFile2.path.substring(46);
        var uri2 = Uri.parse(ROOTIMAGE);
        var request2 = new http.MultipartRequest("POST", uri2);
        var multipartFile2 = new http.MultipartFile(
            "imagesecond", stream2, length2, filename: basename(user2));
        request2.files.add(multipartFile2);
        var response2 = await request2.send();
        if (response2.statusCode == 200) {
          print("Taille $user2");
        } else {
          print("Echec de téléchargement");
        }
      }
       if(imageFile3 !=null) {
         var stream3 = new http.ByteStream(imageFile3.openRead());
         stream3.cast();
         String user3 = user;
         nom3 = imageFile3.path.substring(46);
         if(nom3.contains("image_picker",0)){

         }else{
           nom3 = nom3.substring(29);
         }
         user3 += "/";
         user3 += imageFile3.path.substring(46);
         var length3 = await imageFile3.length();
         var uri3 = Uri.parse(ROOTIMAGE);
         var request3 = new http.MultipartRequest("POST", uri3);
         var multipartFile3 = new http.MultipartFile(
             "imagetertiaire", stream3, length3, filename: basename(user3));
         request3.files.add(multipartFile3);
         var response3 = await request3.send();
         if (response3.statusCode == 200) {
           print("Télécharger");
         } else {
           print("Echec de téléchargement");
         }
       }


      if(imageFile4 !=null) {
        var stream4 = new http.ByteStream(imageFile4.openRead());
        stream4.cast();
        var length4 = await imageFile4.length();
        String user4 = user;
        user4 += "/";
        nom4  = imageFile4.path.substring(46);
        if(nom4.contains("image_picker",0)){

        }else{
          nom4 = nom4.substring(29);
        }
        user4 += imageFile4.path.substring(46);
        var uri4 = Uri.parse(ROOTIMAGE);
        var request4 = new http.MultipartRequest("POST", uri4);
        var multipartFile4 = new http.MultipartFile(
            "image4", stream4, length4, filename: basename(user4));
        request4.files.add(multipartFile4);
        var response8 = await request4.send();
        if (response8.statusCode == 200) {
          print("Taille $user4");
        } else {
          print("Echec de téléchargement");
        }
      }

      var map= Map<String, dynamic>();
      map['action']= _ADD_PROD_ACTION;
      map['idadmin']= idadmin;
      map['admincontact']=admincontact;
      map['adminpseudo']= adminpseudo;
      map['intitule_bien']= intitule_bien;
      map['type_bien']= type_bien;
      map['type_mandat']= type_mandat;
      map['superficie']= superficie;
      map['pays']= pays;
      map['ville']= ville;
      map['quartier']= quartier;
      map['description']= description;
      map['prix']= prix;
      map['negoce']= negoce;
      map['situationadministrative']= situationadministrative;
      map['nbetage']=nbetage;
      map['nbsalon']= nbsalon;
      map['nbchambre']= nbchambre;
      map['nbcuisine']= nbcuisine;
      map['nbboutique']= nbboutique;
      map['nbmagasin']=  nbmagasin;
      map['nbhall']=  nbhall;
      map['nbsalledebain']=  nbsalledebain;
      map['newconstruire']=  newconstruire;
      map['dependance']=  dependance;
      map['garage']=  garage;
      map['piscine']=  piscine;
      map['jardin']=  jardin;
      map['toilettevisiteur']=  toilettevisiteur;
      map['debarras']=  debarras;
      map['compteurperso']=  compteurperso;
      map['arrierecours']=  arrierecours;
      map['balcon']=  	balcon;
      map['meuble']= meuble;
      map['ascensseur']=  ascensseur;
      map['image1']= nom1;
      map['image2']= nom2;
      map['image3']= nom3;
      map['image4']= nom4;
      final response4 = await http.post(ROOT,body:map);
      print('Voici le message du body addProduit: ${response4.body}');
      if(200 == response4.statusCode){
        return response4.body;
      }else{
        return "error";
      }
    }
    catch(e){
      return "error";
    }

  }
 //Envoie d'image
  static Future upload(File imageFile) async{
    var stream  = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length= await imageFile.length();
    var uri = Uri.parse(ROOTIMAGE);
    var request= new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,filename: basename(imageFile.path));
   request.files.add(multipartFile);
   var response= await request.send();
   
   if(response.statusCode==200){
     print("Image téléchargé");
   }else{
     print("Echec de téléchargement");
   }
  }
  //UPDATE
  static Future<String> updateProduit(String id,String intitule_bien, String type_bien,String type_mandat,String superficie,String pays,
      String ville,String quartier,String description, String prix, String negoce,String ancienimage1, String ancienimage2, String ancienimage3,String ancienimage4,File imageFile,File imageFile2,File imageFile3,File imageFile4,String currentimage1,String currentimage2,String currentimage3,String currentimage4) async{
    try{

      String nom1="";
      String nom2="";
      String nom3="";
      String nom4="";

      if(imageFile!=null){
        var stream  = new http.ByteStream(imageFile.openRead());
        stream.cast();
        var length= await imageFile.length();
        nom1 = imageFile.path.substring(46);
        if(nom1.contains("image_picker",0)){

        }else{
          nom1 = nom1.substring(29);
        }
        var uri = Uri.parse(ROOTIMAGE);
        var request= new http.MultipartRequest("POST", uri);
        var multipartFile = new http.MultipartFile("image", stream, length,filename: basename(imageFile.path));
        request.files.add(multipartFile);
        var response= await request.send();

        if(response.statusCode==200){
          print("Image téléchargé");
        }else{
          print("Echec de téléchargement");
        }
      }else{
        nom1=currentimage1;
      }

      if(imageFile2!=null){
        var stream  = new http.ByteStream(imageFile2.openRead());
        stream.cast();
        var length= await imageFile2.length();
        nom2 = imageFile2.path.substring(46);
        if(nom2.contains("image_picker",0)){

        }else{
          nom2 = nom2.substring(29);
        }
        var uri = Uri.parse(ROOTIMAGE);
        var request= new http.MultipartRequest("POST", uri);
        var multipartFile = new http.MultipartFile("image", stream, length,filename: basename(imageFile2.path));
        request.files.add(multipartFile);
        var response= await request.send();
        if(response.statusCode==200){
          print("Image téléchargé");
        }else{
          print("Echec de téléchargement");
        }
      }else{
        nom2=currentimage2;
      }

      if(imageFile3!=null){
        var stream  = new http.ByteStream(imageFile3.openRead());
        stream.cast();
        var length= await imageFile3.length();
        nom3 = imageFile3.path.substring(46);
        if(nom3.contains("image_picker",0)){

        }else{
          nom3 = nom3.substring(29);
        }
        var uri = Uri.parse(ROOTIMAGE);
        var request= new http.MultipartRequest("POST", uri);
        var multipartFile = new http.MultipartFile("image", stream, length,filename: basename(imageFile3.path));
        request.files.add(multipartFile);
        var response= await request.send();

        if(response.statusCode==200){
          print("Image téléchargé");
        }else{
          print("Echec de téléchargement");
        }
      }else{
        nom3=currentimage3;
      }


      if(imageFile4!=null){
        var stream  = new http.ByteStream(imageFile4.openRead());
        stream.cast();
        var length= await imageFile4.length();
        nom4 = imageFile4.path.substring(46);
        if(nom4.contains("image_picker",0)){

        }else{
          nom4 = nom4.substring(29);
        }
        var uri = Uri.parse(ROOTIMAGE);
        var request= new http.MultipartRequest("POST", uri);
        var multipartFile = new http.MultipartFile("image", stream, length,filename: basename(imageFile4.path));
        request.files.add(multipartFile);
        var response= await request.send();

        if(response.statusCode==200){
          print("Image téléchargé");
        }else{
          print("Echec de téléchargement");
        }
      }else{
        nom4=currentimage4;
      }
      var map= Map<String, dynamic>();
      map['action']= _UPDATE_PROD_ACTION;
      map['id']= id;
      map['intitule_bien']= intitule_bien;
      map['type_bien']= type_bien;
      map['type_mandat']= type_mandat;
      map['superficie']= superficie;
      map['pays']= pays;
      map['ville']= ville;
      map['quartier']= quartier;
      map['description']= description;
      map['prix']= prix;
      map['negoce']= negoce;
      map['ancienimage1']= ancienimage1;
      map['ancienimage2']= ancienimage2;
      map['ancienimage3']= ancienimage3;
      map['image1']= nom1;
      map['image2']= nom2;
      map['image3']= nom3;
      map['image4']= nom4;
      final response = await http.post(ROOT,body:map);
      print('Voici le message du body updateProduit: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }
    catch(e){
      return "error";
    }
  }

  //DELETE

  static Future<String> deleteProduit(String id,String image1,String image2, String image3, String image4) async{
    try{
      var map= Map<String, dynamic>();
      map['action']= _DELETE_PROD_ACTION;
      map['id']= id;
      map['image1']= image1;
      map['image2']= image2;
      map['image3']= image3;
      map['image4']= image4;
      final response = await http.post(ROOT,body:map);
      print('Voici le message du body updateProduit: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }
    catch(e){
      return "error";
    }
  }

}

class Userservices{
  static const ROOT ='https://gerestock.com/immo/annonceRequetes.php';
  static const _GET_ALL_ACTION= 'GET_USER';
  static const ROOTLOCALISATION ='https://gerestock.com/immo/localisation.php';

  static Future<List<User>> getUser(String email, String mot_de_passe) async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_ALL_ACTION;
      map['email']= email;
      map['mot_de_passe']= mot_de_passe;
      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getUser : ${response.body}');
      if(200 == response.statusCode){
        List<User> list = parseResponse(response.body);
        return list;
      }else{
        return List<User>();
      }
    }
    catch(e){

      return List<User>();
    }
  }
  static List<User> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }


  //AJOUT DE PRODUITS A LA BASE DE DONNEES
  static Future<String> addUser(String pseudo,String email, String mot_de_passe, String pays,String ville,String quartier,String contact,String representantId) async{
    try{
      var map= Map<String, dynamic>();
      map['action']= "ADD_USER";
      map['pseudo']= pseudo;
      map['email']= email;
      map['mot_de_passe']= mot_de_passe;
      map['pays']= pays;
      map['ville']= ville;
      map['quartier']= quartier;
      map['contact']= contact;
      map['representantId']=representantId;
      final response4 = await http.post(ROOTLOCALISATION,body:map);
      print('Voici le message du body AddUser: ${response4.body}');
      if(200 == response4.statusCode){
        return response4.body;
      }else{
        return "error";
      }
    }
    catch(e){
      return "error";
    }

  }
}



class Paysservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_ALL_ACTION="GET_PAYS";

  static Future<List<Pays>> getPays() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_ALL_ACTION;
      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getPays : ${response.body}');
      if(200 == response.statusCode){
        List<Pays> list = parseResponse(response.body);
        return list;
      }else{
        return List<Pays>();
      }
    }
    catch(e){

      return List<Pays>();
    }
  }
  static List<Pays> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pays>((json) => Pays.fromJson(json)).toList();
  }

}

class Villeservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_VILE_ACTION= 'GET_VILLE';

  static Future<List<Ville>> getVille() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_VILE_ACTION;
      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getVille: ${response.body}');
      if(200 == response.statusCode){
        List<Ville> list = parseResponse(response.body);
        return list;
      }else{
        return List<Ville>();
      }
    }
    catch(e){

      return List<Ville>();
    }
  }
  static List<Ville> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Ville>((json) => Ville.fromJson(json)).toList();
  }

}


class Quartierservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_QUARTIER_ACTION= 'GET_QUARTIER';

  static Future<List<Quartier>> getQuartier() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_QUARTIER_ACTION;

      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getQuartier: ${response.body}');
      if(200 == response.statusCode){
        List<Quartier> list = parseResponse(response.body);
        return list;
      }else{
        return List<Quartier>();
      }
    }
    catch(e){

      return List<Quartier>();
    }
  }
  static List<Quartier> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Quartier>((json) => Quartier.fromJson(json)).toList();
  }

}


class Mandatservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_QUARTIER_ACTION= 'GET_MANDAT';

  static Future<List<Mandat>> getMandat() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_QUARTIER_ACTION;

      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getQuartier: ${response.body}');
      if(200 == response.statusCode){
        List<Mandat> list = parseResponse(response.body);
        return list;
      }else{
        return List<Mandat>();
      }
    }
    catch(e){

      return List<Mandat>();
    }
  }
  static List<Mandat> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Mandat>((json) => Mandat.fromJson(json)).toList();
  }

}

class TypeBienservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_QUARTIER_ACTION= 'GET_MANDAT';

  static Future<List<Mandat>> getMandat() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_QUARTIER_ACTION;

      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getQuartier: ${response.body}');
      if(200 == response.statusCode){
        List<Mandat> list = parseResponse(response.body);
        return list;
      }else{
        return List<Mandat>();
      }
    }
    catch(e){

      return List<Mandat>();
    }
  }
  static List<Mandat> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Mandat>((json) => Mandat.fromJson(json)).toList();
  }

}

class Bienservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_QUARTIER_ACTION= 'GET_LOUER';

  static Future<List<Bienlouable>> getLouer() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_QUARTIER_ACTION;

      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getQuartier: ${response.body}');
      if(200 == response.statusCode){
        List<Bienlouable> list = parseResponse(response.body);
        return list;
      }else{
        return List<Bienlouable>();
      }
    }
    catch(e){

      return List<Bienlouable>();
    }
  }

  static List<Bienlouable> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Bienlouable>((json) => Bienlouable.fromJson(json)).toList();
  }

}

class Etageservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_QUARTIER_ACTION= 'GET_ETAGE';

  static Future<List<Etage>> getEtage() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_QUARTIER_ACTION;

      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getQuartier: ${response.body}');
      if(200 == response.statusCode){
        List<Etage> list = parseResponse(response.body);
        return list;
      }else{
        return List<Etage>();
      }
    }
    catch(e){

      return List<Etage>();
    }
  }
  static List<Etage> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Etage>((json) => Etage.fromJson(json)).toList();
  }

}

class CodePaysservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_QUARTIER_ACTION= 'GET_CODEPAYS';

  static Future<List<codePays>> getCode() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_QUARTIER_ACTION;

      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getQuartier: ${response.body}');
      if(200 == response.statusCode){
        List<codePays> list = parseResponse(response.body);
        return list;
      }else{
        return List<codePays>();
      }
    }
    catch(e){

      return List<codePays>();
    }
  }
  static List<codePays> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<codePays>((json) => codePays.fromJson(json)).toList();
  }

}


class Situationservices{
  static const ROOT ='https://gerestock.com/immo/localisation.php';
  static const _GET_QUARTIER_ACTION= 'GET_SITUATION';

  static Future<List<Situationadmin>> getSituationadmin() async {
    try{
      var map= Map<String, dynamic>();
      map['action']= _GET_QUARTIER_ACTION;

      final response = await http.post(ROOT,body:map);
      print('Voici le message du body getSituationadmin: ${response.body}');
      if(200 == response.statusCode){
        List<Situationadmin> list = parseResponse(response.body);
        return list;
      }else{
        return List<Situationadmin>();
      }
    }
    catch(e){

      return List<Situationadmin>();
    }
  }
  static List<Situationadmin> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Situationadmin>((json) => Situationadmin.fromJson(json)).toList();
  }

}


class Usersnotifications {
  static const ROOT = 'https://gerestock.com/immo/validations.php';
  static Future<List<User>> getUser(String representantId) async {
    try {
      var map = Map<String, dynamic>();
      map['representantId'] = representantId;
      map['action']='SELECT_COMPTE';
      final response = await http.post(ROOT, body: map);
      print('Voici le message du body Usersnotifications : ${response.body}');
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    }
    catch (e) {
      return List<User>();
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<String> updateCompte(String id,String actif) async{
    try{
      var map= Map<String, dynamic>();
      map['action']= 'VALID';
      map['id']= id;
      map['actif']= actif;
      final response = await http.post(ROOT,body:map);
      print('Voici le message du body updateProduit: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }
    catch(e){
      return "error";
    }
  }
}

class SuggestionServices{
  static Future<String> addSuggestion(String message,String contact) async{
    try{
      var map= Map<String, dynamic>();
      map['message']= message;
      map['contact']= contact;
      final response = await http.post('https://gerestock.com/immo/suggestion.php',body:map);
      print('Voici le message du body addProduit: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }
    catch(e){
      return "error";
    }

  }
}