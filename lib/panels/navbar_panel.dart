import 'package:flutter/material.dart';
import 'package:flutter_covid/home_page.dart';

import 'package:flutter_covid/pages/vaccine_page.dart';

import 'package:flutter_covid/panels/newsbar_panel.dart';
import 'package:flutter_covid/panels/tabbar_panel.dart';
import 'package:flutter_covid/panels/vaccbar_panel.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int pageIndex = 0;
  List<Widget> pageList = [
    HomePage(),
    TabBarPanel(),
    //StatesPage(),
    // VaccinePage(),
    VaccBarPanel(),
    NewsBarPanel(),
    // ChartPanel(),
    //IndianPage(),
    //CountryPage(),
    //LocationPage(),
    //InfoPanel()
    //VaccinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // IndexedStack(
          //   index: pageIndex,
          //   children: pageList,
          // ),
          Center(
        child: pageList.elementAt(pageIndex),
      ), //pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        elevation: 0,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedFontSize: 13,
        selectedFontSize: 13,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white54
            : Colors.grey[600],
        selectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.grey[800],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus_outlined),
            label: "Home",
            activeIcon: Icon(Icons.coronavirus_sharp),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_outlined),
            label: 'Data',
            activeIcon: Icon(Icons.leaderboard_sharp),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: "Vaccine",
            activeIcon: Icon(Icons.medical_services),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: "News",
            activeIcon: Icon(Icons.article),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.privacy_tip_outlined),
          //   label: "Help",
          //   activeIcon: Icon(Icons.privacy_tip_sharp),
          // ),
        ],
      ),
    );
  }
}
