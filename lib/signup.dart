import 'package:authenticationapp/screens/Home/home_screen.dart';
import 'package:authenticationapp/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  String email = "",
      password = "",
      name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  bool _obscureText = true;

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && namecontroller.text != "" &&
        mailcontroller.text != "") {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('name', isEqualTo: namecontroller.text)
        .get();
        if(querySnapshot.docs.isNotEmpty){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,

            content:Text( "¡El nombre de usuario ya existe! Por favor, elija otro.",
              style: TextStyle(fontSize: 18.0),

              ),
          ),

          );
          return;
        }


        UserCredential userCredential = await
        FirebaseAuth.instance
            .createUserWithEmailAndPassword
          (email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar
          (SnackBar(
            content: Text(
              "Registrado exitosamente",
              style: TextStyle(fontSize: 20.0),
            )));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'contraseña debil') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "La contraseña proporcionada es demasiado débil",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "correo electrónico ya en uso") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "La cuenta ya existe",
                style: TextStyle(fontSize: 18.0),
              )));
        }
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
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                            return 'Por favor ingrese el nombre';
                          }
                          return null;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(
                            labelText: "Nombre",
                            border: OutlineInputBorder(),
                            hintText: "Ingrese tu nombre"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el correo electrónico';
                          }
                          return null;
                        },
                        controller: mailcontroller,
                        decoration: InputDecoration(
                            labelText: "Correo electronico",
                            border: OutlineInputBorder(),
                            hintText: "Ingresa tu Correo electronico"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Porfavor ingrese su correo electronico';
                          }
                          return null;
                        },
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                            labelText: "Contraseña",
                            border: OutlineInputBorder(),
                            hintText: "Ingresa tu contraseña",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                          )
                        ),
                        obscureText:  _obscureText,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = mailcontroller.text;
                              name = namecontroller.text;
                              password = passwordcontroller.text;

                            });
                          }
                          registration();
                        },
                        child: Text("Registrarse"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "O inicia sesión con",
                style: TextStyle(
                  color:Color(0xffff660e),
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/google.png",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Image.asset(
                    "images/apple1.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
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
                    "¿Ya tienes una cuenta?",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                    },
                    child: Text(
                      "Inico De Session",
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