import 'package:flutter/material.dart';
import 'package:minimal_chat_app/componentes/my_drawer.dart';
import 'package:minimal_chat_app/componentes/user_tile.dart';
import 'package:minimal_chat_app/pantallas/chat_page.dart';
import 'package:minimal_chat_app/servicios/auth/auth_service.dart';
import 'package:minimal_chat_app/servicios/chat/chat_service.dart';

class Inicio extends StatelessWidget {
  Inicio({super.key});

   // chat y auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Bienvenido"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //Construir una lista de usuarios excepto el usuario que inició sesión actualmente.
  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot){
        //error
        if (snapshot.hasError){
          return const Text("error");
        }
        //loading...
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("loading...");
        }
        //Return list review
        return ListView(
          children: snapshot.data!
          .map<Widget>((userData) => _buildUserListItem(userData, context))
          .toList(),
        );
      }
      );
  }
    // build individual list tile for  user
  Widget _buildUserListItem(
    Map<String, dynamic> userData, BuildContext context) {
      if(userData["email"] != _authService.getCurrentUser()!.email){
        return UserTile(
        text: userData["email"],
        onTap: (){
                    //ir al chat => chat_page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                getemail:  userData["email"],
                receiverID: userData["uid"],
                ),
              )
            );
          },
        );
      }else{
        return Container(

        );
      }
  }
}