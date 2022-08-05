import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foody/pages/cart/cart_history.dart';
import 'package:foody/pages/home/main_food_page.dart';
import 'package:foody/pages/user/profile.dart';
import 'package:foody/widgets/big_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = const [
    MainFoodPage(),
    CartHistory(),
    ProfilePage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedItemColor: Colors.teal,
            unselectedItemColor: CupertinoColors.inactiveGray,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart), label: "Your Orders"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_alt), label: "Profile"),
            ]));
  }
}
