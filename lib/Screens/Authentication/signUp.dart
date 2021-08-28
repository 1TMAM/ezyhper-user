import 'package:ezhyper/Widgets/Social_Login/facebook.dart';
import 'package:ezhyper/Widgets/Social_Login/google.dart';
import 'package:ezhyper/Widgets/Social_Login/twitter.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  bool acceptTerms = false;
  final signUp_bloc = SignUpBloc(null);

  bool _passwordVisible;
  bool _confirmPasswordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
      key: _drawerKey,
      backgroundColor: whiteColor,
      body: BlocListener<SignUpBloc, AppState>(
          cubit: signUp_bloc,
          listener: (context, state) {
            var data = state.model as AuthenticationModel;
            if (state is Loading) {
              print("Loading");
              _playAnimation();
            } else if (state is ErrorLoading) {
              var data = state.model as AuthenticationModel;
              print("ErrorLoading");
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
            } else if (state is Done) {
              print("done");
              _stopAnimation();
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return VerificationCode(
                      route: 'SignUp',
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
            }
          },
          child: Directionality(
          textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * .02),
                topPart(),
                SizedBox(height: height * .02),
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
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            right: width * .075, left: width * .075),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .01,
                            ),
                            textWelcome(),
                            SizedBox(
                              height: height * .01,
                            ),
                            textRequiredField(),
                            SizedBox(
                              height: height * .01,
                            ),
                            fullNameTextField(),
                            SizedBox(
                              height: height * .02,
                            ),
                            emailAddressTextField(),
                            SizedBox(
                              height: height * .02,
                            ),
                            phoneNumberTextField(),
                            SizedBox(
                              height: height * .02,
                            ),
                            passwordTextField(),
                            SizedBox(
                              height: height * .02,
                            ),
                            confirmPasswordTextField(),
                            SizedBox(
                              height: height * .02,
                            ),
                            checkBoxAndAccept(),
                            SizedBox(
                              height: height * .01,
                            ),
                            signUpButton(),
                            SizedBox(
                              height: height * .02,
                            ),
                            social(),
                            SizedBox(
                              height: height * .01,
                            ),
                            alreadyHaveAnAccount(),
                            SizedBox(
                              height: height * .01,
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ) )),
    )));
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
        child:InkWell(
            onTap: (){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return SignIn();
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
          )),
          SizedBox(width: width *0.02,),
          Container(
            child: MyText(
              text: translator.translate("SING UP").toUpperCase(),
              size:EzhyperFont.header_font_size,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    )
    ;
  }

  Widget textWelcome() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text: translator.translate("Welcome"),
            size: height * .025,
            weight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget textRequiredField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text: translator.translate("* indicates a required field" ),
            size: height * .017,
            weight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget fullNameTextField() {
    return StreamBuilder<String>(
      stream: signUp_bloc.name,
      builder: (context, snapshot) {
        return CustomTextField(
          secure: false,
          onchange: signUp_bloc.name_change,
          hint: translator.translate("Full Name *"),
          inputType: TextInputType.name,
          suffixIcon: null,
          errorText: snapshot.error,
        );
      },
    );
  }

  Widget emailAddressTextField() {
    return StreamBuilder<String>(
        stream: signUp_bloc.email,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: false,
            onchange: signUp_bloc.email_change,
            hint: translator.translate("Email Address *"),
            inputType: TextInputType.emailAddress,
            suffixIcon: null,
            errorText: snapshot.error,
          );
        });
  }

  Widget phoneNumberTextField() {
    return StreamBuilder<String>(
        stream: signUp_bloc.phone,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: false,
            onchange: signUp_bloc.phone_change,
            hint: translator.translate("Phone Number *"),
            inputType: TextInputType.number,
            suffixIcon: null,
            errorText: snapshot.error,
          );
        });
  }

  Widget passwordTextField() {
    return StreamBuilder<String>(
        stream: signUp_bloc.password,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: !_passwordVisible,
            hint: translator.translate("Password *"),
            onchange: signUp_bloc.password_change,
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

  Widget confirmPasswordTextField() {
    return StreamBuilder<String>(
        stream: signUp_bloc.confirm_password,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: !_confirmPasswordVisible,
            hint: translator.translate("Confirm Password *"),
            onchange: signUp_bloc.confirm_password_change,
            inputType: TextInputType.emailAddress,
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _confirmPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              },
            ),
            errorText: snapshot.error,
          );
        });
  }

  Widget checkBoxAndAccept() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: greyColor,
                  primaryColor: greenColor,
                  accentColor: greenColor),
              child: Checkbox(
                  value: acceptTerms,
                  tristate: false,
                  onChanged: (bool value) {
                    setState(() {
                      acceptTerms = !acceptTerms;
                      print(acceptTerms);
                    });
                  })),
          MyText(
            text: translator.translate("Accept terms & conditions *"),
            size: height * .017,
            color: greyColor,
          )
        ],
      ),
    );
  }

  Widget signUpButton() {

    return StaggerAnimation(
      titleButton: translator.translate("SING UP"),
      buttonController: _loginButtonController.view,
      onTap: () {
        if (!isLoading) {
          if (acceptTerms) {
            signUp_bloc.add(click());
          } else {
            errorDialog(
                context: context, text: translator.translate("Accept terms & conditions *"));
          }
        }
      },
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
              text: translator.translate( "or sign in by"),
              size:EzhyperFont.secondary_font_size,
              weight: FontWeight.bold,
              color: greenColor,
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoginWithGoogle(
                  route: 'signUp',
                ),
                SizedBox(width: 5,),
                TwitterLoginScreen(
                  route: 'signUp',
                ),
                SizedBox(width: 5,),
                LoginWithFacebook(
                  route: 'signUp',
                ),
           /*     Image.asset(
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

  Widget alreadyHaveAnAccount() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width *0.1),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyText(text: translator.translate("Already Have An Account ! "), size: height * .015),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return SignIn();
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
                  text: translator.translate("sign in" ),
                  size: height * .02,
                  color: greenColor,
                )),
          ],
        ),
      ),
    );
  }
}
