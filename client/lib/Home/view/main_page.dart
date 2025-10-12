import 'package:flutter/material.dart';
import 'package:repradar/Home/view/home_page.dart';
import 'package:repradar/Settings/view/settings_page.dart';

class MainPage extends StatefulWidget {
  //constructor of the widget
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //keep track of the current index
  int _currentIndex = 0;

  //final list of pages that will be displayed
  final _pages = [HomePage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //-------------
      body: _pages[_currentIndex],

      //------------
      bottomNavigationBar: Container(
        //----------
        decoration: BoxDecoration(
          color: Colors.white,

          //--------------
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),

        //---------
        child: BottomNavigationBar(
          //----------
          currentIndex: _currentIndex,

          //---------
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },

          //-----------
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
