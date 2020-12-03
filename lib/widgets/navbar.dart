import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:uas/screens/Contents/contents.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List _screens = [
    HomeScreen(),
    StatistikScreen(),
    AboutScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: FancyBottomNavigation(
            tabs: [
                TabData(iconData: Icons.home, title: "Home"),
                TabData(iconData: Icons.insert_chart, title: "Statistik"),
                TabData(iconData: Icons.info, title: "Tentang Kami")
            ],
            onTabChangedListener: (position) {
                setState(() {
                  _currentIndex = position;
                });
            },
        )
      ),
    );
  }
}
