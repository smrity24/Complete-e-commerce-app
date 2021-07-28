import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_com/screens/account_screen.dart';
import 'package:e_com/screens/cart_screen.dart';
import 'package:e_com/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  int selectedIndex;
  NavigationBar({@required this.selectedIndex});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  final List<Widget> _children = [
    // 3 screen widgets
    HomeScreen(),
    // cart screen
    CartScreen(),
    // account screen
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[widget.selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (value) {
            setState(() {
              widget.selectedIndex = value;
            });
          },
          index: widget.selectedIndex,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color(0xff6a4c93),
          height: 50,
          color: Color(0xffdc2f02),
          items: [
            Icon(
              Icons.home,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.add_shopping_cart,
              size: 26,
              color: Colors.white,
            ),
            Icon(
              Icons.account_circle,
              size: 26,
              color: Colors.white,
            ),
          ]),
    );
  }
}
