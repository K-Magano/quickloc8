import 'package:flutter/material.dart';
import 'package:quickloc8/MapScreen/map_screen.dart';
import 'package:quickloc8/UserLocation/user_location.dart';
import 'package:quickloc8/messageScreen/message_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFCCBC),
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
          _navigateToScreen(context, newIndex);
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Quick Loc8',
            icon: Icon(Icons.map, color: Color(0xFFF55722)),
          ),
          BottomNavigationBarItem(
            label: 'Quick Alerts',
            icon: Icon(Icons.message, color: Color(0xFFF55722)),
          ),
          BottomNavigationBarItem(
            label: 'My Location',
            icon: Icon(Icons.location_pin, color: Color(0xFFF55722)),
          ),
        ],
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const MapScreen();
      case 1:
        return const MessageScreen();
      default:
        return const UserLocation();
    }
  }

  void _navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/map');
        break;
      case 1:
        Navigator.pushNamed(context, '/messages');
        break;
      case 2:
        Navigator.pushNamed(context, '/My location');
        break;
    }
  }
}
