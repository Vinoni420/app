// lib/main_screen.dart
import 'package:app/home_screen.dart';
import 'package:app/messages_screen.dart';
import 'package:app/my_jobs_screen.dart';
import 'package:app/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;

  // The list of all your main pages
  final List<Widget> _pages = [
    const HomeScreen(),
    const MyJobsScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  
  // In lib/main_screen.dart

Widget _buildBottomNavigationBar() {
  const String assetPath = 'assets/icons/';
  // Define a single, constant size for all icons. 24.0 is a great standard size.
  const double iconSize = 24.0;

  return BottomNavigationBar(
    currentIndex: _selectedPageIndex,
    onTap: _onItemTapped,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey[600],
    selectedFontSize: 12,
    unselectedFontSize: 12, // Keeping font sizes the same also helps prevent shifts
    items: [
      BottomNavigationBarItem(
        label: 'Home',
        icon: SvgPicture.asset(
          '${assetPath}home.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
        activeIcon: SvgPicture.asset(
          '${assetPath}home_dark.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
      ),
      BottomNavigationBarItem(
        label: 'My Jobs',
        icon: SvgPicture.asset(
          '${assetPath}my_jobs.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
        activeIcon: SvgPicture.asset(
          '${assetPath}my_jobs_dark.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
      ),
      BottomNavigationBarItem(
        label: 'Messages',
        icon: SvgPicture.asset(
          '${assetPath}messages.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
        activeIcon: SvgPicture.asset(
          '${assetPath}messages_dark.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: SvgPicture.asset(
          '${assetPath}profile.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
        activeIcon: SvgPicture.asset(
          '${assetPath}profile_dark.svg',
          width: iconSize,  // <-- ADD THIS
          height: iconSize, // <-- ADD THIS
        ),
      ),
    ],
  );
}
}