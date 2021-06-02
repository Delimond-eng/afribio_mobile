import 'dart:async';

import 'package:afribio/pages/costumer/account_page.dart';
import 'package:afribio/pages/costumer/cart_page.dart';
import 'package:afribio/pages/costumer/home_page.dart';
import 'package:afribio/pages/costumer/user_command_page.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:afribio/utilities/globals.dart';

class HomeScreenCost extends StatefulWidget {
  @override
  _HomeScreenCostState createState() => _HomeScreenCostState();
}

class _HomeScreenCostState extends State<HomeScreenCost> {
  PageController _pageController = PageController();
  final bloc = CounterBloc();
  Function showCart;
  int _selectedIndex = 0;
  int cartCounter = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: [HomePage(), UserCommandePage()],
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded,
                  color: _selectedIndex == 0 ? Colors.green[700] : Colors.grey),
              title: Text("Accueil",
                  style: TextStyle(
                      color: _selectedIndex == 0
                          ? Colors.green[700]
                          : Colors.grey)),
              tooltip: 'accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded,
                  color: _selectedIndex == 1 ? Colors.green[700] : Colors.grey),
              title: Text(
                "Mon afribio",
                style: TextStyle(
                    color:
                        _selectedIndex == 1 ? Colors.green[700] : Colors.grey),
              ),
              tooltip: 'mon afribio'),
        ],
      ),
    );
  }
}
