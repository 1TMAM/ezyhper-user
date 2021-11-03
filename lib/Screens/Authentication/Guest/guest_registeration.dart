import 'package:ezhyper/Screens/Authentication/Guest/guest_verification_code.dart';
import 'package:ezhyper/Widgets/Social_Login/facebook.dart';
import 'package:ezhyper/Widgets/Social_Login/google.dart';
import 'package:ezhyper/Widgets/Social_Login/twitter.dart';
import 'package:ezhyper/Widgets/error_dialog.dart';
import 'package:ezhyper/fileExport.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestRegisteration extends StatefulWidget {
  GlobalKey<ScaffoldState> drawerKey;
  GuestRegisteration({this.drawerKey});
  @override
  _GuestRegisterationState createState() => _GuestRegisterationState();
}

class _GuestRegisterationState extends State<GuestRegisteration> with TickerProviderStateMixin {
  bool acceptTerms = false;
  final signUp_bloc = SignUpBloc(null);

  bool _passwordVisible;
  bool _confirmPasswordVisible;


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
    Navigator.pop(context);
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<SignUpBloc, AppState>(
        bloc: signUp_bloc,
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
            )..show(widget.drawerKey.currentState.context);
          } else if (state is Done) {
            print("done");
            _stopAnimation();
            Navigator.pop(context);
          CustomComponents.guestVerificationCodenBottomSheet(
            drawerKey: widget.drawerKey,
            context: context,
            route: 'GuestSignUp',
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
                              fullNameTextField(),
                              SizedBox(
                                height: height * .01,
                              ),
                              emailAddressTextField(),
                              SizedBox(
                                height: height * .01,
                              ),
                              phoneNumberTextField(),
                              SizedBox(
                                height: height * .01,
                              ),
                              passwordTextField(),
                              SizedBox(
                                height: height * .01,
                              ),
                              confirmPasswordTextField(),
                              SizedBox(
                                height: height * .01,
                              ),
                              checkBoxAndAccept(),
                              SizedBox(
                                height: height * .01,
                              ),
                              signUpButton(),

                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ) ));
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
                LoginWithGoogle(),
                SizedBox(width: 5,),
                TwitterLoginScreen(),
                SizedBox(width: 5,),
                LoginWithFacebook(),
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

}
