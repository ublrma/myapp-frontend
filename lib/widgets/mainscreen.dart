//mainscreen.dart

import 'package:my_app/pages/HistoryPage.dart';
import 'package:my_app/pages/HomePage.dart';
import 'package:my_app/pages/SettingsPage.dart';
import 'package:flutter/material.dart';




class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; 

  static List<Widget> _widgetOptions = <Widget>[
    HistoryScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 30),
            label: 'Түүх',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Нүүр',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30),
            label: 'Тохиргоо',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFBCF0A),
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF00c7c8),
        onTap: _onItemTapped,
      ),
    );
  }
}