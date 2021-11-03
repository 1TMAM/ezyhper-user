import 'package:ezhyper/Widgets/Social_Login/facebook.dart';
import 'package:ezhyper/Widgets/Social_Login/google.dart';
import 'package:ezhyper/Widgets/Social_Login/twitter.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/Widgets/stagger_animation.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:local_auth/local_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometric;
  String authorized = "Not authorized";

  bool _passwordVisible;
  bool _confirmPasswordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkBiometric();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
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
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: NetworkIndicator(
          child: PageContainer(
              child: Scaffold(
                  key: _drawerKey,
                  backgroundColor: whiteColor,
                  body: BlocListener<SigninBloc, AppState>(
                      bloc: signIn_bloc,
                    listener: (context, state) async {
                      var data = state.model as AuthenticationModel;
                      if (state is Loading) {
                        print('login Loading');
                        _playAnimation();
                      } else if (state is Done) {
                        print('login done');
                        _stopAnimation();
                        StaticData.vistor_value = '';
                        Navigator.push(
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

                        //check user frist login go to UserLocation or not go to home page
                       /*
                        CustomComponents.isFirstLogin().then((isFirstLogin) {
                          print("isFirstLogin : ${isFirstLogin}" );
                          isFirstLogin ?    CustomComponents.isLogout().then((is_logout) {
                            is_logout ?  Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) {
                                  return UserLocation(
                                  );
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
                            ) :  Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) {
                                  return CustomCircleNavigationBar(
                                  );
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
                          })
                              : Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return CustomCircleNavigationBar(
                                );
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
                        });
                        */
                      } else if (state is ErrorLoading) {
                        print('login ErrorLoading');
                        _stopAnimation();
                        Flushbar(
                          messageText: Row(
                            children: [
                              Text(
                                '${data.msg}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: whiteColor),
                              ),
                              Spacer(),
                              Text(
                                translator.translate("Try Again" ),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: whiteColor),
                              ),
                            ],
                          ),
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          backgroundColor: redColor,
                          flushbarStyle: FlushbarStyle.FLOATING,
                          duration: Duration(seconds: 6),
                        )..show(_drawerKey.currentState.context);
                      }
                    },
                    child: Directionality(
                      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
                      child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * .04,
                          ),
                          topPart(),
                          SizedBox(
                            height: height * .02,
                          ),
                          Container(
                            child: Expanded(child: _buildBody()),
                          ),
                        ],
                      ),
                    ),
                  )))),
      ) );
  }

  _buildBody() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(height * .05),
              topLeft: Radius.circular(height * .05))),
      child: Container(
        padding: EdgeInsets.only(left: width * .075, right: width * .075),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: height * .04,
            ),
            welcome(),
            toYourAccount(),
            SizedBox(
              height: height * .06,
            ),
            emailTextField(),
            SizedBox(
              height: height * .03,
            ),
            passwordTextField(),
            SizedBox(
              height: height * .02,
            ),
            forgetPassword(),
            SizedBox(
              height: height * .02,
            ),
            signInButton(),
            SizedBox(
              height: height * .04,
            ),
            social(),
            SizedBox(
              height: height * .02,
            ),
            dontHaveAnAccount(),
          ],
        ),
      ),
    );
  }

  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child: Container(
      padding: EdgeInsets.only(left: width * .075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      Padding(
      padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
        child: InkWell(
            child: Container(
              child: translator.currentLanguage == 'ar' ? Image.asset(
                "assets/images/arrow_right.png",
                height: height * .03,
              ) : Image.asset(
                "assets/images/arrow_left.png",
                height: height * .03,
              ),
            ),
            onTap: (){
              StaticData.vistor_value = 'visitor';
              Navigator.push(
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
          )),
          SizedBox(
            width: width * .01,
          ),
          Container(
              child: MyText(
            text: translator.translate("sign in").toUpperCase(),
            size:EzhyperFont.primary_font_size,
            weight: FontWeight.bold,
          )),
        ],
      ),
    ),
    )
    ;
  }

  Widget welcome() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text: translator.translate("Welcome Back!"),
            size: height * .02,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget toYourAccount() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text: translator.translate("sign in to your account"),
            size:EzhyperFont.primary_font_size,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget emailTextField() {
    return StreamBuilder<String>(
        stream: signIn_bloc.email,
        builder: (context, snapshot) {
          print("222222222222222222222222222");
          print("signIn_bloc.email_change : ${signIn_bloc.email_change}");
          return CustomTextField(
            secure: false,
            onchange: signIn_bloc.email_change,
            hint: translator.translate("Email Address *"),
            inputType: TextInputType.emailAddress,
            suffixIcon: null,
            errorText: snapshot.error,
          );
        });
  }

  Widget passwordTextField() {
    return StreamBuilder<String>(
        stream: signIn_bloc.password,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: !_passwordVisible,
            hint: translator.translate("Password *"),
            onchange: signIn_bloc.password_change,
            inputType: TextInputType.text,
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            errorText: snapshot.error,
          );
        });
  }

  Widget forgetPassword() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return ForgetPassword();
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
              child: MyText(
                text: translator.translate( "forget password"),
                size: height * .014,
                weight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget signInButton() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StaggerAnimation(
            titleButton: translator.translate( "sign in").toUpperCase(),
            buttonController: _loginButtonController.view,
            onTap: () {
              if (!isLoading) {
                signIn_bloc.add(click());
              }
            },
          ),
          InkWell(
            child: Image.asset(
              "assets/images/sign_fingerprint.png",
              height: height * .08,
            ),
            onTap: ()async{
              String token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
              print("((token)) : ${token}");

                if(_canCheckBiometric){
                  _authenticate();
                }else{
                  errorDialog(
                    context: context,
                    text: translator.translate("Opps, Your device does not support the fingerprint feature" ),

                  );
                }



            },
          )
        ],
      ),
    );
  }

  Widget social() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: MyText(
              text: translator.translate(  "or sign in by" ).toUpperCase(),
              size: height * .018,
              weight: FontWeight.bold,
              color: greenColor,
            ),
          ),
          SizedBox(
            width: width * 0.1,
          ),
          Container(
            width: width * .35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               LoginWithGoogle(),
                TwitterLoginScreen(),
                LoginWithFacebook(),
              /*  Image.asset(
                  "assets/images/social_phone.png",
                  height: height * .05,
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dontHaveAnAccount() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
              text: translator.translate("don't have an account with us yet ?" ),
              size: height * .015),
          SizedBox(width: 10,),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return SignUp();
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
              child: MyText(
                text:" ${translator.translate( "sign up")}",
                size: height * .02,
                color: greenColor,
              )),
        ],
      ),
    );
  }



  //checking bimetrics
  //this function will check the sensors and will tell us
  // if we can use them or not
  Future<void> _checkBiometric() async{
    bool canCheckBiometric;
    try{
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _authenticate() async{
    bool authenticated = false;
    try{
      print('1');
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: translator.translate( "Touch Sensor to confirm fingerprint to continue"),
          useErrorDialogs: true,
          stickyAuth: false
      );
      if(authenticated){
        var response = await AuthenticationRepository.fingerprint_login();
        print("fingerprint response : ${response.msg}");
        if(response.status ==true){
          sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, response.data.accessToken);
          sharedPreferenceManager.writeData(CachingKey.SOCIAL_LOGIN_TYPE, 'fingerprint');
          sharedPreferenceManager.writeData(CachingKey.USER_NAME, response.data.name);
          sharedPreferenceManager.writeData(CachingKey.EMAIL, response.data.email);
          sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, response.data.phone);
          sharedPreferenceManager.writeData(CachingKey.USER_WALLET, response.data.walletBalance);
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
              transitionDuration: Duration(milliseconds: 10),
            ),
          );
        }else{
          errorDialog(
            context: context,
            text: response.msg
          );
        }

      }else{

      }
      print('2');
    } on PlatformException catch(e){
      print(e);
    }
    if(!mounted) return;

    setState(() {
      authorized = authenticated ? "Autherized success" : "Failed to authenticate";
    });
  }
}
