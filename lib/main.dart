import 'package:ecoresiduos/home/Screen_home.dart';
import 'package:ecoresiduos/mapm/mapm.dart';
import 'package:ecoresiduos/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecoresiduos',
      theme: ThemeData(
   
        primarySwatch: Colors.blue,
      ),
          debugShowCheckedModeBanner: false,
      home: Home(),
     
    );
  }
}

