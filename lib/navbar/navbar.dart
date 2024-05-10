import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patrimonie/anasayfa/anasayfa.dart';
import 'package:patrimonie/anasayfa/harita.dart';
import 'package:patrimonie/anasayfa/profil.dart';
import 'package:patrimonie/anasayfa/takvim.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);
    List<Widget> buildScreens() {
      return [
        const Anasayfa(),
        const Harita(),
        const Takvim(),
        const Profil(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(
            FontAwesomeIcons.house,
          ),
          activeColorPrimary: const Color.fromRGBO(255, 219, 172, 0.8),
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.map),
          activeColorPrimary: const Color.fromRGBO(255, 219, 172, 0.8),
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.calendar),
          activeColorPrimary: const Color.fromRGBO(255, 219, 172, 0.8),
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.user),
          activeColorPrimary: const Color.fromRGBO(255, 219, 172, 0.8),
          inactiveColorPrimary: Colors.white,
        ),
      ];
    }

    return PersistentTabView(
      context,
      margin: const EdgeInsets.all(10),
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: const Color.fromRGBO(54, 59, 116, 0.8),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
