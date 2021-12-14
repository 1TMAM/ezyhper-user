import 'package:ezhyper/Bloc/Order_Bloc/order_bloc.dart';
import 'package:ezhyper/Bloc/Settings_Bloc/settings_bloc.dart';
import 'package:ezhyper/Screens/ContactUs/complainsScreen.dart';
import 'package:ezhyper/Screens/LoyaltySystem/loyaltySystemPromoCode.dart';
import 'package:ezhyper/Screens/Wallet/walletScreen.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  bool isLoading = false;
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pending_earnings();
    settingsBloc.add(AppSettingsEvent());
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }

  void pending_earnings() async {
    StaticData.user_wallet_earnings =
    await sharedPreferenceManager.readInteger(CachingKey.USER_WALLET);
    print("StaticData.user_wallet_earnings : ${StaticData.user_wallet_earnings}");
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
              backgroundColor: whiteColor,
              body: BlocListener<LogoutBloc, AppState>(
                bloc: logout_bloc,
                listener: (context, state) {
                  var data = state.model as AuthenticationModel;
                  if (state is Loading) {
                    print("Loading");
                    _playAnimation();
                  } else if (state is ErrorLoading) {
                    var data = state.model as AuthenticationModel;
                    print("ErrorLoading");
                    _stopAnimation();
                  } else if (state is Done) {
                    print("done");
                    _stopAnimation();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => SignIn()));
                  }
                },
                child: Container(
                  child: Column(
                    children: [topPart(), Expanded(child: buildBody())],
                  ),
                ),
              ),


              /*   bottomNavigationBar: CustomBottomNavigationBar2(
        onTapSettings: false,
        isActiveIconSettings: true,
      ),*/
            )));
  }

  Widget buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:  Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(height * .05),
                  topLeft: Radius.circular(height * .05)),
              color: backgroundColor),
          child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (StaticData.vistor_value == 'visitor')
                        ? Container()
                        : Column(
                      children: [
                        SizedBox(
                          height: height * .02,
                        ),
                        textMyAccount(),
                        SizedBox(
                          height: height * .02,
                        ),
                        allMyAccountItems(),
                        SizedBox(
                          height: height * .01,
                        ),
                      ],
                    ),
                    textOurApp(),
                    SizedBox(
                      height: height * .01,
                    ),
                    allOurAppItems(),
                    SizedBox(
                      height: StaticData.vistor_value == 'visitor' ? height * .07 : height * .02,
                    ),
                    /*(StaticData.vistor_value == 'visitor')
                        ? Container()
                        : logOutButton(),*/
                    logOutButton(),
                    SizedBox(
                      height: height * .02,
                    ),
                  ],
                ),
              )
//

          )),
    );

  }

  Widget allMyAccountItems() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(height * .05))),
          child: Column(
            children: [
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Edit My Profile Info", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return EditMyProfile();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Change Password", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return ChangePassword();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Finger Print", () async{
                var fingerprint_status = await sharedPreferenceManager.readBoolean(CachingKey.FINGERPRINT_STATUS);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return fingerprint_status ? FingerPrintAdded() : FingerPrint();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Manage Address", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return AllAddressesScreen();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Loyalty System", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return LoyaltySystemPromoCode();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Payment Method", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return AllAPaymentMethodsScreen();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("My Order History", () {
                orderBloc.add(UserOrdersEvent());

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return MyOrdersHistory();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow(
                  translator.currentLanguage == 'ar'?  "(${translator.translate("SAR")} ${StaticData.user_wallet_earnings}  ) ${translator.translate("Wallet")}" :
              "${translator.translate("Wallet")} ( ${StaticData.user_wallet_earnings} ${translator.translate("SAR")} )" ,
                      () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return Wallet();
                        },
                        transitionsBuilder: (context, animation8, animation15, child) {
                          return FadeTransition(
                            opacity: animation8,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 10),
                      ),
                    );
                  }),
              SizedBox(
                height: height * .03,
              ),
            ],
          ),
        ));
  }

  Widget allOurAppItems() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FittedBox(
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(height * .05))),
          child: Column(
            children: [
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow(translator.translate("change_language"), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return ChangeLanguageScreen();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Contact Us", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return ComplainsScreen();
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("About Us", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                       return AboutUs();
                      /*return WebviewScaffold(
                          url: 'https://eazyhyper.wothoq.co/privacy',
                          javascriptChannels: jsChannels,
                          mediaPlaybackRequiresUserGesture: false,
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            title: MyText(
                              text: translator.translate("About Us"),
                              size: EzhyperFont.header_font_size,
                              weight: FontWeight.bold,
                              color: blackColor,
                            ),
                            centerTitle: true,

                          ),

                          withZoom: true,
                          withLocalStorage: true,
                          hidden: true,
                          initialChild: Center(child: SpinKitFadingCircle(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index.isEven ? greenColor : whiteColor,
                                ),
                              );
                            },
                          ),)

                      );*/
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Terms & Conditions", () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                         return TermsAndConditions();
                  /*    return WebviewScaffold(
                          url: 'https://eazyhyper.wothoq.co/terms',
                          javascriptChannels: jsChannels,
                          mediaPlaybackRequiresUserGesture: false,
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            centerTitle: true,
                            title: MyText(
                              text: translator.translate("Terms & Conditions"),
                              size: EzhyperFont.header_font_size,
                              weight: FontWeight.bold,
                            ),
                          ),
                          withZoom: true,
                          withLocalStorage: true,
                          hidden: true,
                          initialChild: Center(child: SpinKitFadingCircle(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index.isEven ? greenColor : whiteColor,
                                ),
                              );
                            },
                          ),)

                      );*/
                    },
                    transitionsBuilder: (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }),
              SizedBox(
                height: height * .03,
              ),
              singleSettingRow("Share App", () {
                final RenderBox box = context.findRenderObject();
                Share.share('${settingsBloc.app_link_controller.value}',
                    subject: 'Welcome To Ezhyper',
                    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
              }),
              SizedBox(
                height: height * .03,
              ),
            ],
          ),
        ));
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
            left: width * .075,
            right: width * .075,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                              return  translator.currentLanguage == 'ar' ?
                              CustomCircleNavigationBar(page_index: 4,) : CustomCircleNavigationBar();
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
                        child: translator.currentLanguage == 'ar' ? Image.asset(
                          "assets/images/arrow_right.png",
                          height: height * .03,
                        ) : Image.asset(
                          "assets/images/arrow_left.png",
                          height: height * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * .02,
                    ),
                    Container(
                        child: MyText(
                          text:translator.translate( "SETTINGS"),
                          size:EzhyperFont.primary_font_size,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
    ;
  }

  Widget textMyAccount() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .05, right: width * .05),
          child: MyText(
            text: translator.translate("My Account"),
            size: height * .02,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget singleSettingRow(String text, onTapFunction) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        padding: EdgeInsets.only(left: width * .05, right: width * .05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: translator.translate(text),
              size: height * .02,
              weight: FontWeight.normal,
            ),
            translator.currentLanguage == 'ar' ? Image.asset(
              "assets/images/arrow_left_md.png",
              height: height * .03,
            ) : Image.asset(
              "assets/images/arrow_right_md.png",
              height: height * .03,
            )
          ],
        ),
      ),
    );
  }

  Widget textOurApp() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * .05, right: width * .05),
          child: MyText(
            text: translator.translate("Our App"),
            size: height * .02,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget logOutButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StaggerAnimation(
        titleButton: StaticData.vistor_value == 'visitor'
            ? translator.translate( "sign in") : translator.translate("LOGOUT"),
        buttonController: _loginButtonController.view,
        onTap: () {
          StaticData.vistor_value == 'visitor'
              ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()))
              : logout_bloc.add(logoutClick());
        });
  }
}
