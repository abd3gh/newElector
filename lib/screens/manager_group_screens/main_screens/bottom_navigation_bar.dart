import 'package:elector/constants.dart';
import 'package:elector/screens/manager_group_screens/main_screens/activist/activist_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/follower_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/groups_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/nakhabeen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/support/voterwithoutnum.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/main_menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigatorScreenState createState() => _BottomNavigatorScreenState();
}

class _BottomNavigatorScreenState extends State<BottomNavigatorScreen> {
  int currentIndex = 0;

  final screens = [
    Nakhibeen(),
    FollowerScreen(),
    ActivistScreen(),
    GroupScreen(),
    MainMenu(),
  ];

//sahar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: color1,
        selectedItemColor: white,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        unselectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        selectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        onTap: (index) => setState(
          () => currentIndex = index,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 27,
            ),
            label: 'الناخبين',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.front_hand_rounded,
              size: 27,
            ),
            label: 'التابعين',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              size: 27,
            ),
            label: 'الناشطين',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
              size: 27,
            ),
            label: 'المجموعات',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              size: 27,
            ),
            label: 'خيارات',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
