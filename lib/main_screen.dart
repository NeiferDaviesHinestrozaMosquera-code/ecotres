// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:ecoresiduos/mapm/mapm.dart';
import 'package:ecoresiduos/screens/Novedades.dart';
import 'package:ecoresiduos/screens/Tics.dart';
import 'package:flutter/material.dart';

import 'package:ecoresiduos/screens/navbar_key.dart';
import 'package:ecoresiduos/screens/account_user.dart';
import 'package:ecoresiduos/services/list_page.dart';
import 'package:ecoresiduos/mapm/map_marker.dart';

class MainScreen extends StatefulWidget {

@override 
 _MainScreen createState() => _MainScreen();

}

class _MainScreen extends State<MainScreen> {
  int selectedIndex = 0;
  final screen =  [ListNoteEco(),ListPage(),Mapmscreen(title: 'EcoPuntos Yopal',),ListNoteTics(),HomeScreen()];

  @override 
Widget build (BuildContext context){
return Scaffold(
bottomNavigationBar: CurvedNavigationBar(
  index : selectedIndex,
      key: NarbarKey.getKey(),
        items: [
          Icon(Icons.home, size:30,), ///Inicio
          Icon(Icons.delete, size: 30), ///INFORMACION
          Icon(Icons.map, size: 30), ///mAPA
          Icon(Icons.chat, size: 30), ///ECOTICS
          Icon(Icons.person, size: 30,) /// INFORMACION USER
          ],
          onTap: (index){
     setState(() {
  selectedIndex = index;
                  });
          },
          animationCurve: Curves.easeInBack,
          animationDuration: const Duration(milliseconds: 300),
        ),
      body:  screen[selectedIndex],
      );
    }
}