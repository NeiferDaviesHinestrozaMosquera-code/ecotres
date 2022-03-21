import 'package:ecoresiduos/components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool showSpinner = false; ///revisar
   final _auth = FirebaseAuth.instance;  //falta

    // editing controller
  final TextEditingController emailController = new TextEditingController();
    String email = " ";


    // form key
  final _formKey = GlobalKey<FormState>();
   
  //
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner ,
      child: Scaffold(
        appBar: AppBar(
          title: Text(' Recuperar clave de ingreso'),
          automaticallyImplyLeading: false,
          backwardsCompatibility: false, ///revisar
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Inicio de sesion' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 40 ) ,),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                    children:[
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()
                        ),
                        onChanged: (String value){
                          email = value;
                        },
                        validator: ( value){
                          return value!.isEmpty ? 'Digite su correo electronico' :  null;
                        },
                      ),
                    
              
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: RoundButton(title: 'Enviar clave de recuperacion al correo ', onPress: () async{
                          
                          if(_formKey.currentState!.validate()){

                            setState(() {
                              showSpinner=true;
                            });
                            try{
                             _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                              
                               setState(() {
                              showSpinner=false;
                            });

                               toastMessage('Revisar correo de recuperacion');
                             }).onError((error, stackTrace){
                               toastMessage(error.toString());
                             });

                            }
                            catch(e){
                              print(e.toString());
                              toastMessage(e.toString());
                              setState(() {
                              showSpinner=false;
                            });
                            }

                          }
    
                        }),
                      )
                    ]
                  )),
                )
              ]
           
          ),
        ),
      ),
    );
  }
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

}