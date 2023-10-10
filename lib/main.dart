import 'package:flutter/material.dart';
import 'package:varchandise/screens/login_register_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginRegisterScreen();
  }
}
