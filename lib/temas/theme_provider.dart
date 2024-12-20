import 'package:flutter/material.dart';
import 'package:minimal_chat_app/temas/dark_mode.dart';
import 'package:minimal_chat_app/temas/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData =>_themeData;

  bool get isDarkMode => _themeData == darktMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if (_themeData == lightMode){
      themeData = darktMode;
    }else{
        themeData == lightMode;
      }
  }
}