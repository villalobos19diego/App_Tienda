// ignore_for_file: use_build_context_synchronously

import 'package:authenticationapp/forgot_password.dart';
import 'package:authenticationapp/screens/Home/home_screen.dart';
import 'package:authenticationapp/service/auth.dart';
import 'package:authenticationapp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});


  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Usuario no encontrado') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No se encontró ningún usuario para ese correo electrónico",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'contraseña incorrecta') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Contraseña incorrecta proporcionada por el usuario",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/car.PNG",
                fit: BoxFit.cover,
              ),


              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Porfavor ingrese su correo electronico';
                          }  else if  (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Por favor ingrese un correo electrónico válido';

                          }
                          return null;
                        },
                        controller: mailcontroller,
                        decoration: InputDecoration(
                          labelText: "Correo electronico",
                          border: OutlineInputBorder(),
                          hintText: "Ingrese su correo electronico",
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Porfavor ingrese su contraseña';
                          }else if(value.length < 6){
                            return 'la contraseña debe tener al menos 6 caracteres';
                          }else if( !RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$').hasMatch(value)){

                            return 'La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                          border: OutlineInputBorder(),
                          hintText: "Ingresa tu contraseña",
                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, ),
                          )
                        ),
                        obscureText: _obscureText,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = mailcontroller.text;
                              password = passwordcontroller.text;
                            });
                          }
                          userLogin();
                        },
                        child: Text("Iniciar sesión"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.
                  push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                },
                child: Text(
                  "¿Has olvidado tu contraseña?",
                  style: TextStyle(
                    color: Color(0xffff660e),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "o Inicia sesión con",
                style: TextStyle(
                  color: Color(0xffff660e),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AuthMethods().signInWithGoogle(context);
                    },
                    child: Image.asset(
                      "images/google.png",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      AuthMethods().signInWithApple();
                    },
                    child: Image.asset(
                      "images/apple1.png",
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes una cuenta?",
                    style: TextStyle(
                      color: Color(0xffff660e),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        color: Color(0xffff660e),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
