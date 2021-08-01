import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:whenflix/screens/screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [_screens[_selectedIndex]],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF121a23),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Color(0xFF4a749e),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color(0xFF15212a),
              color: Color(0xFF798ea6),
              tabs: [
                GButton(
                  icon: IconlyLight.home,
                  text: 'Home',
                ),
                GButton(
                  icon: IconlyLight.search,
                  text: 'Search',
                ),
                GButton(
                  icon: IconlyLight.notification,
                  text: 'Notifications',
                ),
                GButton(
                  icon: IconlyLight.bookmark,
                  text: 'My List',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
