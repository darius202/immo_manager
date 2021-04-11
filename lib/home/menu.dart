import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:immo_manager/abonnement/abonnement.dart';
import 'package:immo_manager/constantes/constants.dart';
import 'package:immo_manager/experience/DataTables.dart';
import 'package:immo_manager/home/home.dart';
import 'package:immo_manager/userconditions/conditions.dart';
import 'package:immo_manager/models/Annonces.dart';
import 'package:immo_manager/profil/profil.dart';
class MyBottomBarWidget extends StatefulWidget {
  MyBottomBarWidget();
  @override
  _MyBottomBarWidgetState createState() => _MyBottomBarWidgetState();
}

int _selectedIndex = 0;


class _MyBottomBarWidgetState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: ClampingScrollPhysics(),
        onPageChanged: (index) {
          pageChanged(index);
        },
        controller: _pageController,
        children: [
           Home(),
          DataTables(user[0]),
          Abonnement(),
          ProfilePage(),
          Condition(),
        ],
      ),
      bottomNavigationBar: navyBottomBar(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  Widget navyBottomBar() {
    return BottomNavyBar(
      backgroundColor: kPrimaryColor,
      selectedIndex: _selectedIndex,
      showElevation: true, // use this to remove appBar's elevation
      onItemSelected: (index) {
        bottomTapped(index);
      },
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Accueil'),
          activeColor: Colors.white,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.reply_all),
            title: Text('Annonces'),
          activeColor: Colors.white,),
        BottomNavyBarItem(
          icon: Icon(Icons.attach_money),
          title: Text('Compte'),
          activeColor: Colors.white,),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profil'),
          activeColor: Colors.white,),
        BottomNavyBarItem(
          icon: Icon(Icons.info_outline),
          title: Text('Conditions'),
          activeColor: Colors.white,)
      ],
    );
  }
}