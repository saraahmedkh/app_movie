import 'package:flutter/material.dart';
import 'package:flutter_application/screens/update_profile/update_profile_screen.dart';
import 'package:flutter_application/tabs/favorite_tab.dart';
import 'package:flutter_application/tabs/search_tab.dart';

import '../../tabs/home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List tabs=[
    HomeTab(),
    SearchTab(),
    FavoriteTab(),
    UpdateProfileScreen(),
  ];

  void changeTab(int index){
    setState(() {
      selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap:  changeTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
