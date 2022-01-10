import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ecoresiduos/screens/navbar_key.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({ Key? key }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
     child: Center(child: ElevatedButton(child: Text('Continuar con el shopping'),
     onPressed: (){
       
     },
     ),),
     
    );
  }
}