import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:varchandise/sections/profile_screen.dart';
import 'package:varchandise/sections/history_section.dart';
import 'package:varchandise/sections/home_section.dart';
import 'package:varchandise/sections/shopping_cart_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.res});
  final dynamic res;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSectionIndex = 0;
  Widget? currentScreen;
  Color homeButtonColor = const Color(0xff7408C2);
  Color cartButtonColor = const Color(0xff8A8A8A);
  Color historyButtonColor = const Color(0xff8A8A8A);
  Color accountButtonColor = const Color(0xff8A8A8A);

  void changeCurrentIndex() {
    setState(() {
      if (currentSectionIndex == 0) {
        currentScreen = HomeSection(
          res: widget.res,
        );
        homeButtonColor = const Color(0xff7408C2);
        cartButtonColor = const Color(0xff8A8A8A);
        historyButtonColor = const Color(0xff8A8A8A);
        accountButtonColor = const Color(0xff8A8A8A);
      } else if (currentSectionIndex == 1) {
        currentScreen = const ShoppingCartSection();
        homeButtonColor = const Color(0xff8A8A8A);
        cartButtonColor = const Color(0xff7408C2);
        historyButtonColor = const Color(0xff8A8A8A);
        accountButtonColor = const Color(0xff8A8A8A);
      } else if (currentSectionIndex == 2) {
        currentScreen = const HistorySection();
        homeButtonColor = const Color(0xff8A8A8A);
        cartButtonColor = const Color(0xff8A8A8A);
        historyButtonColor = const Color(0xff7408C2);
        accountButtonColor = const Color(0xff8A8A8A);
      } else if (currentSectionIndex == 3) {
        currentScreen = const ProfileScreen();
        homeButtonColor = const Color(0xff8A8A8A);
        cartButtonColor = const Color(0xff8A8A8A);
        historyButtonColor = const Color(0xff8A8A8A);
        accountButtonColor = const Color(0xff7408C2);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                currentSectionIndex = 0;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.house,
                size: 30,
                color: homeButtonColor,
              ),
            ),
            IconButton(
              onPressed: () {
                currentSectionIndex = 1;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.cartShopping,
                size: 30,
                color: cartButtonColor,
              ),
            ),
            IconButton(
              onPressed: () {
                currentSectionIndex = 2;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.clockRotateLeft,
                size: 30,
                color: historyButtonColor,
              ),
            ),
            IconButton(
              onPressed: () {
                currentSectionIndex = 3;
                changeCurrentIndex();
              },
              icon: Icon(
                FontAwesomeIcons.user,
                size: 30,
                color: accountButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
