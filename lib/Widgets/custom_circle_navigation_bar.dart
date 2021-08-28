import 'package:ezhyper/Screens/Notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';

/*

class CustomCircleNavigationBar extends StatefulWidget {
  final int page_index;
  CustomCircleNavigationBar({this.page_index});
  @override
  _CustomCircleNavigationBarState createState() => _CustomCircleNavigationBarState();
}

class _CustomCircleNavigationBarState extends State<CustomCircleNavigationBar> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 55;
    double arcHeightWithNotch = 55;

    if (size.height > 700) {
      barHeight = 55;
    } else {
      barHeight = size.height * 0.15;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }
    print("page_index : ${widget.page_index}");
    return CircleBottomNavigationBar(
      initialSelection: widget.page_index,
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
      onTabChangedListener: (index) => setState((){
        print("widget.page_index  :  ${widget.page_index}");
        print("index  : ${index}");

        switch(index){
          case 0:
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return CustomCircleNavigationBar();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 3),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return Notifications();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 3),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return MyFavourites();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 3),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return ShoppingCart();
                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 3),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
       return CustomCircleNavigationBar(page_index: 4,);                },
                transitionsBuilder:
                    (context, animation8, animation15, child) {
                  return FadeTransition(
                    opacity: animation8,
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 3),
              ),
            );
            break;
        }
      }),
    );
  }
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: Icons.home,
      iconSize: 25.0,
      fontSize: 12,
      fontWeight: FontWeight.bold,
      onClick: (){

      }
    ),
    TabData(
      icon: Icons.notifications,
      iconSize: 25,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.favorite,
      iconSize: 25,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.shopping_cart,
      iconSize: 25,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.menu,
      iconSize: 25,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),

  ];
}
*/

import 'package:flutter/material.dart';

import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';


class CustomCircleNavigationBar extends StatefulWidget {
  final int page_index;
  CustomCircleNavigationBar({this.page_index = 0});
  @override
  _CustomCircleNavigationBarState createState() => _CustomCircleNavigationBarState();
}

class _CustomCircleNavigationBarState extends State<CustomCircleNavigationBar> {
  int currentPage = 0;
  final List<Widget> _pages = [

    HomeScreen(),
    Notifications(),
    MyFavourites(),
    ShoppingCart(),
    Settings()
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
      body: _pages[currentPage],
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
    TabData(
      icon: Icons.home,
      iconSize: 25.0,

    ),
    TabData(
      icon: Icons.notifications,
      iconSize: 25,

    ),
    TabData(
      icon: Icons.favorite,
      iconSize: 25,

    ),
    TabData(
      icon: Icons.shopping_cart,
      iconSize: 25,

    ),
    TabData(
      icon: Icons.menu,
      iconSize: 25,

    ),
  ];
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'History',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Alarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: Text(
            'Alarm ',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}