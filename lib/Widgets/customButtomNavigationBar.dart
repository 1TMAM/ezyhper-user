import 'package:ezhyper/Screens/Notifications/notifications.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/screens/Shopping_Cart/shoppingCartScreen.dart';

class CustomBottomNavigationBar2 extends StatelessWidget {
  final bool isActiveIconHome;
  final bool isActiveIconInNotifications;
  final bool isActiveIconFavourites;
  final bool isActiveIconCart;
  final bool isActiveIconSettings;
  final bool onTapHome;
  final bool onTapNotifications;
  final bool onTapFavourites;
  final bool onTapCart;
  final bool onTapSettings;
  CustomBottomNavigationBar2(
      {this.isActiveIconHome: false,
      this.isActiveIconInNotifications : false,
      this.isActiveIconFavourites: false,
      this.isActiveIconCart: false,
        this.isActiveIconSettings: false,
      this.onTapHome: true,
      this.onTapNotifications: true,
      this.onTapFavourites: true,
      this.onTapSettings: true ,
      this.onTapCart: true ,
      });
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: greyColor,
                  blurRadius: 10.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              )),
          height: height * .09,
          width: width,
          child: Center(
            child: Directionality(
          textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child:  Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                    onTap: onTapHome ==false ? (){print(" home  pressed");} : () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>CustomCircleNavigationBar(),));
                      /*     Navigator.push(
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
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );*/
                    },
                    child: isActiveIconHome == false
                        ? Container(
                      child: Image.asset(
                        "assets/images/menu_home.png",
                        width: width * .07,
                      ),
                    )
                        : Stack(
                      children: [
                        Container(
                            height: height * .2,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenColor),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/menu_white_home.png",
                                  width: width * .08,
                                ),
                              ),
                            )),
//                        redPoint will be here
                        Container()
                      ],
                    )),
                InkWell(
                    onTap: onTapNotifications ==false ? (){print(" notifications pressed ");} : () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>Notifications(),
                      ));
                      /* Navigator.push(
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
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );*/
                    },
                    child: isActiveIconInNotifications == false
                        ? Container(
                      child: Image.asset(
                        "assets/images/menu_notification.png",
                        width: width * .07,
                      ),
                    )
                        : Stack(
                      children: [
                        Container(
                            height: height * .2,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenColor),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/menu_white_notification.png",
                                  width: width * .08,
                                ),
                              ),
                            )),
//                        redPoint will be here
                        Container()
                      ],
                    )),
                InkWell(
                    onTap: onTapFavourites ==false ? (){print(" favourit  pressed");} : () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>MyFavourites(),
                      ));
                      /*          Navigator.push(
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
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );*/
                    },
                    child: isActiveIconFavourites  == false
                        ? Container(
                      child: Image.asset(
                        "assets/images/menu_favourite.png",
                        width: width * .07,
                      ),
                    )
                        : Stack(
                      children: [
                        Container(
                            height: height * .2,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenColor),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/menu_white_favourite.png",
                                  width: width * .08,
                                ),
                              ),
                            )),
//                        redPoint will be here
                        Container()
                      ],
                    )),
                InkWell(
                    onTap: onTapCart  ==false ? (){print(" cart  pressed");} : () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>ShoppingCart(),
                      ));
                      /* Navigator.push(
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
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );*/
                    },
                    child: isActiveIconCart  == false
                        ? Container(
                      child: Image.asset(
                        "assets/images/menu_cart.png",
                        width: width * .07,
                      ),
                    )
                        : Stack(
                      children: [
                        Container(
                            height: height * .2,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenColor),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/menu_white_cart.png",
                                  width: width * .08,
                                ),
                              ),
                            )),
//                        redPoint will be here
                        Container()
                      ],
                    )),
                InkWell(
                    onTap: onTapSettings ==false ? (){print(" setting  pressed");} : () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>Settings(),
                      ));
                      /*Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
       return CustomCircleNavigationBar(page_index: 4,);                            },
                            transitionsBuilder:
                                (context, animation8, animation15, child) {
                              return FadeTransition(
                                opacity: animation8,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 10),
                          ),
                        );*/
                    },
                    child: isActiveIconSettings  == false
                        ? Container(
                      child: Image.asset(
                        "assets/images/menu_setting.png",
                        width: width * .07,
                      ),
                    )
                        : Stack(
                      children: [
                        Container(
                            height: height * .2,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: greenColor),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/menu_white_setting.png",
                                  width: width * .08,
                                ),
                              ),
                            )),
//                        redPoint will be here
                        Container()
                      ],
                    )),
              ],
            ),
          ),
          ),
          ),
        ),
      ],
    );
  }

}
