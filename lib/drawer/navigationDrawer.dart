import 'package:flutter/material.dart';
import 'package:immo_manager/abonnement/abonnement.dart';
import 'package:immo_manager/constantes/transition.dart';
import 'package:immo_manager/drawer/createDrawerHeader.dart';
import 'package:immo_manager/experience/DataTables.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/pageValidator.dart';
import 'package:immo_manager/profil/profil.dart';
import 'package:immo_manager/userconditions/conditions.dart';
import 'createDrawerBodyItem.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
              icon: Icons.person,
              text: 'Mon profil',
              onTap: () {
                Navigator.push(context, SlideRightRoute(page: ProfilePage()));
              }
          ),
          createDrawerBodyItem(
              icon: Icons.attach_money,
              text: 'Dépôt',
              onTap: () {
                Navigator.push(context, SlideRightRoute(page: Abonnement()));
              }
          ),
          createDrawerBodyItem(
              icon: Icons.reply_all,
              text: 'Mes annonces',
              onTap: () {
                Navigator.push(context, SlideRightRoute(page:DataTables(user[0])));
              }
          ),
          user[0].admini=="oui"?
          createDrawerBodyItem(
              icon: Icons.notifications_active,
              text: 'Notifications',
              onTap: () {
                Navigator.push(context, SlideRightRoute(page:Notifications(user[0])));
              }
          ):Container(),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.share,
            text: "Partager l'application",
            onTap: () {

            }
          ),
          createDrawerBodyItem(
          icon: Icons.info_outline,
            text: "Conditions d'utilisation",
            onTap: () {
              Navigator.push(context, SlideRightRoute(page:Condition()));
            }
          ),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}