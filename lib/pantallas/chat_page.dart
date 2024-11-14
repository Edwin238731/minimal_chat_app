import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/componentes/my_textfield.dart';
import 'package:minimal_chat_app/servicios/auth/auth_service.dart';
import 'package:minimal_chat_app/servicios/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String getemail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.getemail,
    required this.receiverID,
  });

  //text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send a message
  void sendMessage() async {
    // if there is something insade the textfiels
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMenssage(receiverID, _messageController.text);

      //clear textController
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getemail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //display all message
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),

        ],
      ),
    );
  }
      //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // errores
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading..");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      }
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    return Text(data["message"]);
  }

  // Build massage input
  Widget _buildUserInput(){
    return Row(
      children: [
        //textfield should take up most of the space
        Expanded(
          child: MyTextfield(
            placeholder: "Type a message",
            password: false,
            controller: _messageController)
          ),

          //send botton
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward),
          ),
      ],
    );
  }
}
