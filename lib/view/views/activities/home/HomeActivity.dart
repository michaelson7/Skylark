import 'package:flutter/material.dart';
import 'package:skylark/view/constants/constants.dart';
import 'package:skylark/view/widgets/customeAppBar.dart';

import '../../fragments/homeFragment.dart';
import '../../fragments/templateFragment.dart';

class HomeActivity extends StatefulWidget {
  static String id = "HomeActivity";
  const HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeFragment(),
    const TemplateFragment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(
        title: "Home",
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
