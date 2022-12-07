import 'package:flutter/material.dart';

import '../tabs/my_home_tab.dart';
import '../tabs/library_tab.dart';
import '../tabs/favorite_tab.dart';
import '../tabs/profile_tab.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = './tabs-routeName';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    const MyHomeTab(),
    const LibraryTab(),
    const FavoriteTab(),
    ProfileTab()
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final theme2 = Theme.of(context);
    return Scaffold(
      backgroundColor:
          _selectedPageIndex == 0 ? Colors.grey[100] : Colors.white,
      body: SafeArea(
child: IndexedStack(
    index: _selectedPageIndex, 
    children: _pages,) 
      ),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        showUnselectedLabels: true,
        onTap: _selectPage,
        backgroundColor: theme.secondary,
        unselectedItemColor: Colors.grey,
        selectedItemColor: theme2.primaryColor,
        currentIndex: _selectedPageIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedPageIndex == 1 ? Icons.book : Icons.book_outlined),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedPageIndex == 2
                ? Icons.favorite_outlined
                : Icons.favorite_outline_outlined),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedPageIndex == 3 ? Icons.person : Icons.person_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
