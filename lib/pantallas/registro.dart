import 'package:flutter/material.dart';
import 'package:minimal_chat_app/servicios/auth/auth_service.dart';
import 'package:minimal_chat_app/componentes/my_button.dart';
import 'package:minimal_chat_app/componentes/my_textfield.dart';

class ResgistroPage extends StatelessWidget {
    //email y pw contollers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confpwController = TextEditingController();

    // Funcionalidad del text regristro
  final void Function()? onTap;


  ResgistroPage({
    super.key,
    required this.onTap,
    });
  //metodo de registro
  void register(BuildContext context) {
    //registro
    final _auth = AuthService();
//confirmacion de contraceñas para la creacion de un usuario
    if (_pwController.text == _confpwController.text){
      try{
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      }catch(e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }else{
      //las contraceñas no coincidieron
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Las contraceñas no coinciden")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),


            //Mensage de bienvenida
            Text(
              "Bienvenido registrate en Menssage App",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height:15),


            //email textfaild
            MyTextfield(
              password: false,
              placeholder: 'Email',
              controller: _emailController,
            ),
            const SizedBox(height: 25),

            // password textfaild
            MyTextfield(
              password: true,
              placeholder: 'Contraceña',
              controller: _pwController,
            ),
            const SizedBox(height: 10),

            //Confirmacion password textfaild
            MyTextfield(
              password: true,
              placeholder: 'Confirma tu contraceña',
              controller: _confpwController,
            ),
            const SizedBox(height: 25),

            
            //login button
            MyButton(
              text: "Registrame",
              onTap: () => register(context),
            ),
            const SizedBox(height: 25),


            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ya estas registrado   ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Inicia Sección Ahora",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}