import 'package:ezhyper/fileExport.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:ezhyper/Screens/Authentication/verification_timer.dart';

class VerificationCode extends StatefulWidget {
  final String route;
  VerificationCode({this.route});
  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  String client_email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    user_email();
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
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
                key: _drawerKey,
                backgroundColor: whiteColor,
                body: BlocListener<ForgetPasswordBloc, AppState>(
                  bloc: forgetPassword_bloc,
                  listener: (context, state) async {
                    var data = state.model as AuthenticationModel;
                    if (state is Loading) {
                      if(state.indicator == 'checkOtpClick') {
                        _playAnimation();
                      }else if(state.indicator == 'resendOtpClick') {

                      }
                    } else if (state is Done) {
                      _stopAnimation();

                      if(state.indicator == 'checkOtpClick'){
                        if(widget.route=='SignUp'){
                          StaticData.vistor_value = '';
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return UserLocation();
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
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return ResetPassword();
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

                      }else if(state.indicator == 'resendOtpClick') {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return VerificationCode();
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
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return VerificationCode();
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
                  },
                  child: Directionality(
                      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
                      child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * .06,
                          ),
                          topPart(),
                          SizedBox(
                            height: height * .04,
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
                              child: Container(
                                padding: EdgeInsets.only(
                                    right: width * .075, left: width * .075),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * .06,
                                    ),
                                    stepTwo(),
                                    textInter(),
                                    SizedBox(
                                      height: height * .06,
                                    ),
                                    verificationTextFields(),
                                    SizedBox(
                                      height: height * .05,
                                    ),
                                    yourEmail(),
                                    email(),
                                    SizedBox(
                                      height: height * .04,
                                    ),
                                    verifyButton(),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    didntRecieveTheCode()
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
                ))));
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
        child:  InkWell(
            onTap: () {
              Navigator.pushReplacement(
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
            child:  Container(

                child: translator.currentLanguage == 'ar' ? Image.asset(
                  "assets/images/arrow_right.png",
                  height: height * .03,
                ) : Image.asset(
                  "assets/images/arrow_left.png",
                  height: height * .03,
                ),
              ),


          ),),
          SizedBox(
            width: width * .03,
          ),
          Container(
              child: MyText(
            text: translator.translate("VERIFICATION CODE"),
            size:EzhyperFont.primary_font_size,
            weight: FontWeight.bold,
          )),
        ],
      ),
    ),
    )
    ;
  }

  Widget stepTwo() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text:translator.translate("Step 1 of 3"),
            size: height * .028,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget textInter() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text:
                translator.translate("Please Enter The Verification Code Sent To Your email address"),
            size: height * .015,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

//  all text fields in the Row
//  https://pub.dev/packages/pin_code_fields
  Widget verificationTextFields() {
    return   Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child:  StreamBuilder<String>(
                stream: forgetPassword_bloc.code,
                builder: (context,snapshot){
                  return PinCodeTextField(
                    onTextChanged: forgetPassword_bloc.code_change,
                    // errorBorderColor: snapshot.error,
                    autofocus: true,
                    hideCharacter: false,
                    highlight: true,
                    highlightColor: greenColor,
                    defaultBorderColor: Color(0xFFC4BEBE ),
                    hasTextBorderColor: greenColor,
                    maxLength: 4,
                    pinBoxWidth: 40,
                    pinBoxHeight: 40,
                    hasUnderline: false,
                    wrapAlignment: WrapAlignment.spaceAround,
                    pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    pinTextStyle: TextStyle(fontSize: 15,color: greenColor,fontWeight: FontWeight.bold),
                    pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
                    //                    pinBoxColor: Colors.green[100],
                    pinTextAnimatedSwitcherDuration:
                    Duration(milliseconds: 300),
                    //                    highlightAnimation: true,
                    highlightAnimationBeginColor: Colors.black,
                    highlightAnimationEndColor: Colors.white12,
                    keyboardType: TextInputType.number,
                    errorBorderColor: redColor,


                  );
                },
              ),
    );

  }

// default one
  Widget singleCodeTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: TextFormField(
        textDirection: TextDirection.rtl,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: greyColor,
          fontSize: height * .05,
        ),
        obscureText: false,
        showCursor: false,
        cursorColor: greyColor,
        decoration: InputDecoration(
          suffixIcon: null,
          hintText: null,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: greenColor)),
        ),
      ),
    );

  }

  Widget verifyButton() {
    return   StaggerAnimation(
      titleButton: translator.translate("verify" ).toUpperCase(),
      buttonController: _loginButtonController.view,
      onTap: () {
        if (!isLoading) {
          forgetPassword_bloc.add(checkOtpClick());
        }
      },
    );

  }

  Widget yourEmail() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text: translator.translate("Your Email Address"),
            size: height * .017,
            color: greyColor,
          ),
        ],
      ),
    );
  }

  Widget email() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            //text: "${forgetPassword_bloc.email_controller.value}",
            text: "${client_email}",
            size: height * .02,
          ),
        ],
      ),
    );
  }
  void user_email()async{
    client_email= await sharedPreferenceManager.readString(CachingKey.FORGET_PASSWORD_EMAIL);
  }
  Widget didntRecieveTheCode() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: translator.translate("Did not receive the code?"),
            size:EzhyperFont.primary_font_size,
            weight: FontWeight.bold,
          ),

          TimerCountDownWidget(onTimerFinish: (){
          },),
        ],
      ),
    );
  }
}
