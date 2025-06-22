import 'package:app/home_screen.dart';
import 'package:app/messages_screen.dart';
import 'package:app/my_jobs_screen.dart';
import 'package:app/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem {
  final String label;
  final String assetName; 
  const NavItem({required this.label, required this.assetName});
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const MyJobsScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  final List<NavItem> _navItems = const [
    NavItem(label: 'Home', assetName: 'home'),
    NavItem(label: 'My Jobs', assetName: 'my_jobs'),
    NavItem(label: 'Messages', assetName: 'messages'),
    NavItem(label: 'Profile', assetName: 'profile'),
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

  Widget _buildBottomNavigationBar() {
    const String assetPath = 'assets/icons/';
    const double iconSize = 24.0;

    return BottomNavigationBar(
      currentIndex: _selectedPageIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[600],
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: _navItems.map((item) {
        return BottomNavigationBarItem(
          label: item.label,
          icon: SvgPicture.asset(
            '$assetPath${item.assetName}.svg',
            width: iconSize,
            height: iconSize,
          ),
          activeIcon: SvgPicture.asset(
            '$assetPath${item.assetName}_dark.svg',
            width: iconSize,
            height: iconSize,
          ),
        );
      }).toList(),
    );
  }
}