import 'package:ezhyper/Screens/Notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'dart:ui' as ui;

class CustomCircleNavigationBar extends StatefulWidget {
  final int page_index;
  CustomCircleNavigationBar({this.page_index = 0});
  @override
  _CustomCircleNavigationBarState createState() => _CustomCircleNavigationBarState();
}

class _CustomCircleNavigationBarState extends State<CustomCircleNavigationBar> {
  int currentPage = 0;
  final List<Widget> _pages = [
    translator.currentLanguage == 'en' ?  HomeScreen() : Settings(),
    translator.currentLanguage == 'en' ? Notifications() :  ShoppingCart(),
    MyFavourites(),
    translator.currentLanguage == 'en' ?  ShoppingCart() : Notifications(),
    translator.currentLanguage == 'en' ?  Settings() : HomeScreen()
  ];

  @override
  void initState() {
    currentPage = widget.page_index;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 60;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
      body:  Directionality(
        textDirection: translator.currentLanguage == 'ar' ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        child: _pages[currentPage],
      ),
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: greenColor,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => currentPage = index),
      ),
    );
  }
}

List<TabData> getTabsData() {
  return [
   translator.currentLanguage == 'en' ? TabData(
      icon: Icons.home,
      iconSize: 25.0,

    ) : TabData(
     icon: Icons.menu,
     iconSize: 25,
   ),



    translator.currentLanguage == 'en' ? TabData(
      icon: Icons.notifications,
      iconSize: 25,

    ) :  TabData(
      icon: Icons.shopping_cart,
      iconSize: 25,

    ),
    TabData(
      icon: Icons.favorite,
      iconSize: 25,

    ),



   translator.currentLanguage == 'en'? TabData(
      icon: Icons.shopping_cart,
      iconSize: 25,

    ) : TabData(
     icon: Icons.notifications,
     iconSize: 25,

   ) ,



    translator.currentLanguage == 'en'?  TabData(
      icon: Icons.menu,
      iconSize: 25,

    ) :  TabData(
      icon: Icons.home,
      iconSize: 25.0,

    ) ,
  ];
}

