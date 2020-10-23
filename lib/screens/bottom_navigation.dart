import 'package:flutter/material.dart';
import 'package:fusalbookings/screens/home/home.dart';
import 'package:fusalbookings/screens/home/menu.dart';
import 'package:fusalbookings/screens/home/profile.dart';
import 'package:fusalbookings/screens/home/squad.dart';
import 'package:fusalbookings/screens/home/user_bookings.dart';


class BNB extends StatefulWidget {
  @override
  _BNBState createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screen = [
    Home(), SquadPage(), UserBookings(), Profile(), Menu()
  ];
  void _onPageChange(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTap(int index){
    _pageController.animateToPage(index, duration: Duration(milliseconds: 250), curve: Curves.linear);
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.white,
      //   primaryColor: Colors.green,
      //   accentColor: Colors.green[200],

      // ),
      home: Scaffold(
          body: PageView(
            controller: _pageController,
            children: _screen,
            onPageChanged: _onPageChange,
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.green,
            fixedColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(size: 35),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                title: Text('Squad'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text('Bookings'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                title: Text('Menu'),
              ),
            ],
            onTap: (index) => _onTap(index),
          ),
        ),
    );
  }
}