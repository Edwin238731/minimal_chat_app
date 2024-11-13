import 'package:flutter/material.dart';
import 'package:minimal_chat_app/servicios/auth/auth_service.dart';
import 'package:minimal_chat_app/pantallas/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

    void cerrarsesion() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              //Lista del drawer
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("INICIO"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    //funcionalidad
                    Navigator.pop(context);
                  },
                ),
              ),
              //configuraciones
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("Configuraciones"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>const SettingsPage(),
                      )
                    );
                  },
                ),
              ),
            ],
          ),
//*********************************************************** */
          //cerrar sesion
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title:const Text("CERRAR SESION"),
              leading:const Icon(Icons.logout),
              onTap:cerrarsesion,
            ),
          ),
        ],
      )
    );
  }
}