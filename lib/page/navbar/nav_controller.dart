import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patrimonie/page/anasayfa.dart';
import 'package:patrimonie/page/harita.dart';
import 'package:patrimonie/page/profil.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;
  List pages = const [
    Anasayfa(),
    Harita(),
    Profil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              selectedItemColor: Colors.redAccent,
              unselectedItemColor: Colors.black,
              currentIndex: myCurrentIndex,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.house,
                      size: 20,
                    ),
                    label: "Anasayfa"),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.map,
                      size: 20,
                    ),
                    label: "Harita"),
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.user,
                      size: 20,
                    ),
                    label: "Profil"),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
