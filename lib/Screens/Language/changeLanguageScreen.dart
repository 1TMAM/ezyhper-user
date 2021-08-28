import 'package:clippy_flutter/triangle.dart';
import 'package:ezhyper/Widgets/custom_appBar.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:ezhyper/main.dart';
import 'package:flutter/material.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  bool radioValue = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child:  Scaffold(
      backgroundColor: whiteColor,
      body: Directionality(
        textDirection:  translator.currentLanguage=='ar'? TextDirection.rtl : TextDirection.ltr,
        child: Container(
            child: Column(children: [
            topPart(),
              SizedBox(
                height: height * .0,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: width * .075,
                    left: width * .075,
                    top: height * .0,
                    bottom: height * .0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(height * .05),
                        topRight: Radius.circular(height * .05)),
                    color: backgroundColor),
                child: Container(
                  height: height * .035,
                ),
              ),
              Expanded(
                  child: Container(
                    color: backgroundColor,
                    child: _buildBody(),
                  ))
            ])),
      )
    )));
  }
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child: Container(
        child: Container(
          height: height * .10,
          color: whiteColor,
          padding: EdgeInsets.only(
            left: width * .075, right: width * .025, ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
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
                        );
                      },
                      child: Container(
                        child:  translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) :Image.asset(
                          translator.currentLanguage =='ar'? "assets/images/arrow_right.png" : "assets/images/arrow_left.png",                        height: height * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                        child: MyText(
                          text: translator.translate(  "change_language" ).toUpperCase(),
                          size: height * .016,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
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
                  );
                },
                child: Container(
                  child: Image.asset(
                    "assets/images/cart.png",
                    height: height * .03,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    )
    ;
  }

  _buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: width * .0, right: width * .0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(height * .05),
              topLeft: Radius.circular(height * .05)),
          color: backgroundColor),
      child: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            textSelectLanguage(),

            SizedBox(height: height*.01,),
            languagesOptionsCard(),
            SizedBox(height: height*.2,),

            CustomSubmitAndSaveButton(
              buttonText: translator.translate('save'),
              onPressButton: (){navigationToSettings();},),
            SizedBox(height: height*.01,),


          ],
        ),
      ),
    );
  }
  Widget navigationToSettings(){
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return CustomCircleNavigationBar(page_index: 4,);          ;
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

  }
  Widget textSelectLanguage() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: width * .075, left: width * .075),
          child: MyText(text: translator.translate('select_language'),weight: FontWeight.bold,),
        ),
      ],
    );
  }
  Widget languagesOptionsCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(height*.02)), color: whiteColor),
        padding: EdgeInsets.only(left: width * .03, right: width * .075),

        width: width,
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                changeLang("ar");
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 40,
                child:    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        translator.currentLanguage == "ar"
                            ? Icon(Icons.radio_button_checked,color: greenColor,)
                            : Icon(Icons.radio_button_unchecked),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(translator.translate('arabic_language')),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset("assets/images/lan_arabic.png"),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => changeLang("en"),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          translator.currentLanguage == "en"
                              ? Icon(Icons.radio_button_checked,color: greenColor,)
                              : Icon(Icons.radio_button_unchecked),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(translator.translate('english_language')),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("assets/images/lan_english.png"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void changeLang(String lang) async {
    setState(() {
      translator.setNewLanguage(
        context,
        newLanguage: '${lang}',
        remember: true,
        restart: false,
      );
    });

    MyApp.setLocale(context, Locale('${lang}'));

  }


}
