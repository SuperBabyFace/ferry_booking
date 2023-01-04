import 'package:ferry_booking/database/userSession.dart';
import 'package:ferry_booking/pages/bookingFerryPage.dart';
import 'package:ferry_booking/pages/displayFerryBooking.dart';
import 'package:ferry_booking/pages/signout.dart';
import 'package:ferry_booking/theme/theme.dart';
import 'package:flutter/material.dart';
import '../pages/bookingFerryPage.dart';
import '../pages/bookingFerryPage.dart';
import '../models/user.dart';
import '';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({
    Key? key,
    required this.user,
    this.currentPage = 0,
  }) : super(key: key);

  // Get current login user details
  final User user;
  final int currentPage;

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  // Function for bottom nav bar
  final List<String> pageTitle = [
    
    "View Booking",
    "Settings",
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.currentPage;
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of bottom nav bar page
    final List<Widget> _widgetOptions = <Widget>[
      displayFerryBooking(user: widget.user),
      SettingPage(),
    ];

    return Scaffold(
      body: Container(
        // Display current selected bottom navbar page
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration_outlined),
            label: 'View Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
