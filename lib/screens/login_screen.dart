// ignore_for_file: prefer_const_constructors

import 'package:ecoresiduos/Admin/adminwork.dart';
import 'package:ecoresiduos/main_screen.dart';
import 'package:ecoresiduos/screens/forgotpassword.dart';
//import 'package:ecoresiduos/screens/home_screen.dart';
import 'package:ecoresiduos/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;  //falta

  String? errorMessage;


  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Por favor, introduzca su correo electrónico");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Por favor, introduzca una dirección de correo electrónico válida");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Correo electronico",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
         
          
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contraseña",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
           RegExp regex = new RegExp(r'^.{6,}$');
            if (passwordController.text.isEmpty ||
                !regex.hasMatch(passwordController.text)) {
              Fluttertoast.showToast(
                  msg:
                      "La contraseña debe tener más de 6 digitos y/o no debe estar vacia",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              signIn(emailController.text, passwordController.text);
            }
          },
      
           
                    
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    
  
    
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/ecologo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: <Widget>[
                          Text("¿No tiene una cuenta? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                          
                            // ignore: prefer_const_constructors
                            child: Text(
                              "Inscríbase en",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                   if(_auth.currentUser?.uid == 'Pk9husl0GYcQqeXfvHLl8q0hPif1'){
                     Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => adminwork())),
                  } else {
                     Navigator.of(context).pushReplacement(
                     MaterialPageRoute(builder: (context) => MainScreen())),
                    }
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
         case "invalid-email":
            errorMessage = "Su dirección de correo electrónico parece estar malformada.";

            break;
          case "wrong-password":
            errorMessage = "Tu contraseña es incorrecta.";
            break;
          case "user-not-found":
            errorMessage = "El usuario con este correo electrónico no existe.";
            break;
          case "user-disabled":
            errorMessage = "El usuario con este correo electrónico ha sido desactivado.";
            break;
          case "demasiadas solicitudes":
            errorMessage = "Demasiadas solicitudes";
            break;
          case "operación no permitida":
            errorMessage = "El inicio de sesión con correo electrónico y contraseña no está habilitado.";
            break;
          default:
            errorMessage = "Se ha producido un error indefinido.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
 
}
