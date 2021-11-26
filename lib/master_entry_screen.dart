// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mittalfoods_app/screens/trollies_screen.dart';
import 'screens/product_screen.dart';
import 'screens/trey_trolley_screen.dart';


/// This is the stateful widget that the main application instantiates.
class MasterEntryScreen extends StatefulWidget {
  const MasterEntryScreen({Key? key}) : super(key: key);

  @override
  State<MasterEntryScreen> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MasterEntryScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    TreyOrTrolleyScreen( pagetype: 'TROLLEY'),
    TreyOrTrolleyScreen( pagetype: 'TREY'),
    TrolliesScreen(),
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
            icon: Icon(Icons.shopping_cart, color:Colors.blue),
            label: 'Trolley',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox, color:Colors.blue),
            label: 'Trey',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank, color:Colors.blue),
            label: 'Product',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
