import 'package:flutter/material.dart';
import 'package:minimal_chat_app/pantallas/login.dart';
import 'package:minimal_chat_app/pantallas/registro.dart';

class LoginOrRegistrer extends StatefulWidget {
  const LoginOrRegistrer({super.key});

  @override
  State<LoginOrRegistrer> createState() => _LoginOrRegistrerState();
}

class _LoginOrRegistrerState extends State<LoginOrRegistrer> {
  //inicializar el login
  bool showLogin = true;

  //funcion para iniciar el login
  void togglesPages(){
    setState(() {
      showLogin = !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLogin){
      return Login(
        onTap:togglesPages,
      );
    }else{
      return ResgistroPage(
        onTap: togglesPages
      );
    }
  }
}