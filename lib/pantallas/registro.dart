import 'package:flutter/material.dart';
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
  void register() {

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
              controler: _emailController,
            ),
            const SizedBox(height: 25),

            // password textfaild
            MyTextfield(
              password: true,
              placeholder: 'Contraceña',
              controler: _pwController,
            ),
            const SizedBox(height: 10),

            //Confirmacion password textfaild
            MyTextfield(
              password: true,
              placeholder: 'Confirma tu contraceña',
              controler: _confpwController,
            ),
            const SizedBox(height: 25),

            
            //login button
            my_button(
              text: "Registrame",
              onTap: register,
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