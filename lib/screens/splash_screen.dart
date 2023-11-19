import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varchandise/rest/rest_login_api.dart';
import 'package:varchandise/screens/home_screen.dart';
import 'package:varchandise/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? sharedPreferences;
  Widget currentScreen = const LoginScreen();

  void checkUserSavedLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.getString('customerID') == null &&
        sharedPreferences!.getString('usermail') == null) {
      currentScreen = const LoginScreen();
    } else {
      String email = sharedPreferences!.getString('usermail').toString();
      String password = sharedPreferences!.getString('password').toString();
      var res = await userLogin(email.trim(), password.trim());
      setState(() {
        currentScreen = HomeScreen(res: res);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserSavedLogin();
  }

  @override
  Widget build(BuildContext context) {
    return currentScreen;
  }
}
