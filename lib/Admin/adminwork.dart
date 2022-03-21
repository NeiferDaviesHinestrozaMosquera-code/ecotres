import 'package:ecoresiduos/Admin/ListAdmin.dart';
import 'package:ecoresiduos/Admin/eco/list_page_eco.dart';
import 'package:ecoresiduos/Admin/tics/list_page_tics.dart';
import 'package:ecoresiduos/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class adminwork extends StatefulWidget {
  const adminwork({ Key? key }) : super(key: key);

  @override
  State<adminwork> createState() => _adminworkState();
}

class _adminworkState extends State<adminwork> {
  @override
    
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
             automaticallyImplyLeading: false,
             centerTitle: true,
             
             title: Text('PANEL ADMINISTRADOR'),
              actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
             ),

            body: Center(
              
              child: Column (
              children: [

                Container(
                height: 52.0,
                margin: EdgeInsets.all(15),
                child: RaisedButton(
                  onPressed: () => {
                     Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>const ListAdmin (), //cambio
                  ),
                )
                  },
                  padding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color.fromARGB(128, 39, 134, 10), Color.fromARGB(255, 48, 224, 236)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(28.0)
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 280.0, minHeight: 52.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Lista EcoUsuarios",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                ),

                Container(
                height: 52.0,
                margin: EdgeInsets.all(15),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListNote (), //cambio
                  ),
                );
                  },
                  padding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color.fromARGB(255, 176, 85, 0), Color.fromARGB(255, 48, 224, 236)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(28.0)
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 280.0, minHeight: 52.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Crud EcoNovedades",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),),

                Container(
                height: 52.0,
                margin: EdgeInsets.all(15),
                child: RaisedButton(
                  onPressed: (){
                     Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ListNoteTics(),
                  ),
                );
                  },
                  padding: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75.0)),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xff00b09b), Color.fromARGB(255, 224, 19, 146)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(28.0)
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 280.0, minHeight: 52.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Crud EcoTics",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),)


            ]
          )
        )
    
    );

  child: const Icon(Icons.add);
  } 


  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}