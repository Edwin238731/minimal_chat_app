import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String  placeholder;
  final bool password;
  final TextEditingController controller;
  
  const MyTextfield({
    super.key,
    required this.placeholder,
    required this.password,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: password,
        controller: controller,
        decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: placeholder,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
      ),
    );
  }
}