import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/servicios/auth/login_or_registrer.dart';
import 'package:minimal_chat_app/pantallas/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
//build(BuildContext context): El método que Flutter llama para dibujar este widget.
//Recibe un BuildContext, que proporciona información sobre la posición y jerarquía del widget en la aplicación.
    return Scaffold(
      body: StreamBuilder(
//StreamBuilder: Un widget que reconstruye su contenido cada vez que hay un nuevo valor en el Stream.
        stream: FirebaseAuth.instance.authStateChanges(),
/*stream: Especifica la fuente de datos en tiempo real.
FirebaseAuth.instance.authStateChanges(),
emite actualizaciones cada vez que el estado de autenticación del usuario cambia (inicia sesión, cierra sesión, etc.). */
        builder: (context, snapshot){
//builder: Define cómo construir la interfaz de usuario basada en los datos recibidos del Stream.
          //user is logged in
          if (snapshot.hasData){
//snapshot: Contiene información sobre el estado del Stream,
//.hasData: Verifica si hay datos en el snapshot. Si es true, significa que hay un usuario autenticado.
            return Inicio();
          }
          else{
            return const LoginOrRegistrer();
          }
        }
        )
    );
  }
}