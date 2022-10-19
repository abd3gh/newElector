import 'package:elector/constants.dart';
import 'package:elector/screens/box_man_screen/send_numbers.dart';
import 'package:elector/screens/box_man_screen/show_box_numbers.dart';
import 'package:elector/screens/box_man_screen/show_electors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AddElectors/add_electors.dart';

class BottomNavigatorCashier extends StatefulWidget {
  const BottomNavigatorCashier({Key? key}) : super(key: key);

  @override
  _BottomNavigatorCashierState createState() => _BottomNavigatorCashierState();
}

class _BottomNavigatorCashierState extends State<BottomNavigatorCashier> {
  int currentIndex = 0;

  final screens = [
    AddElector(),
    AddElector(remove: true),
    ShowElector(),
    SendNumbers(),
    ShowNumbers()
  ];

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
        selectedFontSize: 13,
        unselectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        selectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        onTap: (index) => setState(
          () => currentIndex = index,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              size: 25,
            ),
            label: 'تشطيب',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_off,
              size: 25,
            ),
            label: 'الغاء تشطيب',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
              size: 25,
            ),
            label: 'عرض المصوتين',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.how_to_vote,
              size: 25,
            ),
            label: 'فرز الصناديق',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.where_to_vote,
              size: 25,
            ),
            label: 'عرض الأصوات',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
