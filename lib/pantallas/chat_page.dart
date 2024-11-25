import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/componentes/chat_bubble.dart';
import 'package:minimal_chat_app/componentes/my_textfield.dart';
import 'package:minimal_chat_app/servicios/auth/auth_service.dart';
import 'package:minimal_chat_app/servicios/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String getemail;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.getemail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //For textfield focus
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    //  implement initState
    super.initState();
    // add listener to focus node
    _focusNode.addListener((){
      if(_focusNode.hasFocus){
        //cause a delay so that the keybooard has time to show up
        //then the amount of remaining space will be calculated,
        // then scroll down
        //se genera un retaso al scroll del texto cuando aparece el teclado
        Future.delayed(
          const Duration (milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // wait a bit for list to be build, then scroll bottom
    Future.delayed(
      const Duration(microseconds: 500),
      () => scrollDown(),
      );

  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();

  void scrollDown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
        duration: const Duration (seconds:1),
        curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  // send a message
  void sendMessage() async {
    // if there is something insade the textfiels
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMenssage(widget.receiverID, _messageController.text);

      //clear textController
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.getemail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
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
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // errores
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading..");
        }
        // return list view
        return ListView(
          controller: _scrollController,
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

    //is current user
    bool isCurrentUser = data ['senderID'] == _authService.getCurrentUser()!.uid;

    //align menssage to the rigth if sender id the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser
            ),
        ],
      )
    );
  }

  // Build massage input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //textfield should take up most of the space
          Expanded(
            child: MyTextfield(
              placeholder: "Type a message",
              password: false,
              controller: _messageController,
              focusNode: _focusNode,
              )
            ),
            //send botton
            Container(
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle
                ),
                margin:const  EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  ),
              ),
            ),
        ],
      ),
    );
  }
}
