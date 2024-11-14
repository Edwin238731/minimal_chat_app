import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/servicios/auth/auth_gate.dart';
//import 'package:minimal_chat_app/auth/login_or_registrer.dart';
import 'package:minimal_chat_app/firebase_options.dart';
//import 'package:minimal_chat_app/pantallas/login.dart';
//import 'package:minimal_chat_app/temas/light_mode.dart';
import 'package:minimal_chat_app/temas/theme_provider.dart';
import 'package:provider/provider.dart';
//import 'package:minimal_chat_app/temas/dark_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
