import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String getemail;
  
  const ChatPage({
    super.key,
    required this.getemail,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getemail),
        centerTitle: true,
        ),
    );
  }
}