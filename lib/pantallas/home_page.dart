import 'package:flutter/material.dart';
import 'package:minimal_chat_app/auth/auth_service.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  void cerrarsesion() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido"),
        centerTitle: true,
        actions: [
          //boton cerrarsesion
          IconButton(onPressed: cerrarsesion, icon: Icon(Icons.logout))
        ],
        ),
    );
  }
}