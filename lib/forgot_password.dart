import 'package:authenticationapp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool _hasError = false;
  String? _errorMessage;

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "¡Se ha enviado un correo electrónico para restablecer la contraseña!",
        style: TextStyle(fontSize: 20.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "Usuario no encontrado") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Ningún usuario encontrado para ese correo electrónico.",
          style: TextStyle(fontSize: 20.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.0),
              Text(
                "Recuperar tu contraseña",
                style: TextStyle(
                  color: Color(0xffff660e),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Ingresa tu correo electrónico",
                style: TextStyle(
                  color: Color(0xffff660e),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        }
                        return null;
                      },
                      controller: mailcontroller,
                      style: TextStyle(color: Color(0xffff660e)),
                      decoration: InputDecoration(
                        hintText: "Correo electrónico",
                        hintStyle: TextStyle(fontSize: 18.0, color: Color(0xffff660e)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xffff660e),
                          size: 30.0,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffff660e), width: 2.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0), // Espacio adicional para separar el campo de texto del mensaje de error
                    if (_formkey.currentState != null && !_formkey.currentState!.validate())
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Por favor ingresa tu correo electrónico',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    SizedBox(height: 15.0),
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = mailcontroller.text;
                              });
                              resetPassword();
                            }
                          },
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xffff660e),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Enviar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿No tienes una cuenta?",
                          style: TextStyle(fontSize: 18.0, color: Color(0xffff660e)),
                        ),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => SignUp()));
                          },
                          child: Text(
                            "Crear",
                            style: TextStyle(
                              color:Color(0xffff660e),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
