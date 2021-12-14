import 'package:ezhyper/fileExport.dart';

class Intro3 extends StatefulWidget {
  @override
  _Intro3State createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
          textDirection: translator.currentLanguage == 'ar'
              ? TextDirection.rtl
              : TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * .04,
                ),
                logo(),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                    height: height * .85,
                    width: width,
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                              height * .05,
                            ),
                            topLeft: Radius.circular(height * .05))),
                    child: Column(
                      children: [
                        image(),
                        text(),
                        SizedBox(
                          height: height * .04,
                        ),
                        skip(),
                      ],
                    )),
              ],
            ),
          )),
    );
  }
//  1-logo 2-image 3-text 4-skip

  Widget logo() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: width * .03, top: width * .03, right: width * .03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: SvgPicture.asset(
              'assets/images/ezhyper_logo.svg',
              color: greenColor,
              height: height * .06,
            ),
          ),
        ],
      ),
    );
  }

  Widget image() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .6,
      height: height * .5,
      child: Image.asset(
        "assets/images/img_slide3.png",
      ),
    );
  }

  Widget text() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .75,
      child: MyText(
        text: translator.translate(
            "Online stores platform: a multi-store platform that aims to enable the merchant to sell his goods easily and directly deal with the customer"),
        size: height * .019,
      ),
    );
  }

  Widget skip() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(right: width * .08, left: width * .08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //use in arabic version
          translator.currentLanguage == 'ar'
              ? InkWell(
                  onTap: () {
                    translator.currentLanguage == 'ar'
                        ? Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return Intro2();
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
                          )
                        : Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return translator.currentLanguage == 'ar'
                                    ? CustomCircleNavigationBar(
                                        page_index: 4,
                                      )
                                    : CustomCircleNavigationBar();
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
                          );
                  },
                  child: translator.currentLanguage == 'ar'
                      ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        )
                      : Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        ))
              : InkWell(
                  onTap: () {
                    translator.currentLanguage == 'ar'
                        ? Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return Intro2();
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
                          )
                        : Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return translator.currentLanguage == 'ar'
                                    ? CustomCircleNavigationBar(
                                        page_index: 4,
                                      )
                                    : CustomCircleNavigationBar();
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
                          );
                  },
                  child: translator.currentLanguage == 'ar'
                      ? Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        )
                      : Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        )),

          Container(
            width: width * .25,
            child: translator.currentLanguage == 'ar'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        givenHeight: height * .015,
                        givenWidth: height * .015,
                        buttonColor: greyColor,
                      ),
                      CustomButton(
                        givenHeight: height * .015,
                        givenWidth: height * .015,
                        buttonColor: greyColor,
                      ),
                      CustomButton(
                          givenHeight: height * .015, givenWidth: width * .12),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          givenHeight: height * .015, givenWidth: width * .12),
                      CustomButton(
                        givenHeight: height * .015,
                        givenWidth: height * .015,
                        buttonColor: greyColor,
                      ),
                      CustomButton(
                        givenHeight: height * .015,
                        givenWidth: height * .015,
                        buttonColor: greyColor,
                      ),
                    ],
                  ),
          ),

          //use in arabic version
          translator.currentLanguage == 'ar'
              ? InkWell(
                  onTap: () {
                    translator.currentLanguage == 'ar'
                        ? Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return translator.currentLanguage == 'ar'
                                    ? CustomCircleNavigationBar(
                                        page_index: 4,
                                      )
                                    : CustomCircleNavigationBar();
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
                          )
                        : Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return Intro2();
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
                          );
                  },
                  child: translator.currentLanguage == 'en'
                      ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        )
                      : Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        ))
              : InkWell(
                  onTap: () {
                    translator.currentLanguage == 'ar'
                        ? Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return translator.currentLanguage == 'ar'
                                    ? CustomCircleNavigationBar(
                                        page_index: 4,
                                      )
                                    : CustomCircleNavigationBar();
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
                          )
                        : Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return Intro2();
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
                          );
                  },
                  child: translator.currentLanguage == 'en'
                      ? Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        )
                      : Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        )),
        ],
      ),
    );
  }
}
