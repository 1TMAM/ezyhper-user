import 'package:ezhyper/fileExport.dart';


class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}
class _ResetPasswordState extends State<ResetPassword> with TickerProviderStateMixin{
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
            child:  Scaffold(
              key: _drawerKey,
      backgroundColor: whiteColor,
      body: BlocListener<ForgetPasswordBloc, AppState>(
          bloc: forgetPassword_bloc,
        listener: (context, state) {
          var data = state.model as AuthenticationModel;
          if (state is Loading) {
            _playAnimation();
          } else if (state is ErrorLoading) {
            var data = state.model as AuthenticationModel;
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

            Flushbar(
              messageText: Row(
                children: [
                  Text(
                    '${data.msg}',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: whiteColor),
                  ),
                  Spacer(),
                 InkWell(
                   onTap: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(
                       builder: (Context)=>SignIn()
                     ));
                   },
                   child:  Text(
                     translator.translate( "sign in"),
                     textDirection: TextDirection.rtl,
                     style: TextStyle(color: whiteColor),
                   ),
                 )
                ],
              ),
              flushbarPosition: FlushbarPosition.BOTTOM,
              backgroundColor: greenColor,
              flushbarStyle: FlushbarStyle.FLOATING,
            )..show(_drawerKey.currentState.context);

          }
        },
        child:Directionality(
        textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
        child:  Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*.06,),
              topPart(),
              SizedBox(height: height*.04,),
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
                  child: Container(padding: EdgeInsets.only(right: width*.075,left: width*.075),
                    child: Column(
                      children: [
                        SizedBox(height: height*.06,),
                        stepThree(),
                        textInterPassword(),
                        SizedBox(height: height*.06,),
                        passwordTextField(),
                        SizedBox(height: height*.03,),
                        confirmTextField(),
                        SizedBox(height: height*.03,),
                        SizedBox(height: height*.02,),
                        SizedBox(height: height*.02,),
                        resetButton()




   ],),)),],),),),)
      ))));}
   
  Widget topPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl :TextDirection.ltr,
      child:  Container(
      padding: EdgeInsets.only(left: width * .075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      Padding(
      padding: EdgeInsets.only(right: translator.currentLanguage == 'ar'? height * 0.02 : 0 ,left: translator.currentLanguage == 'ar'? 0 : height * 0.02),
        child:  InkWell(onTap: (){
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

          },
            child: Container(
                child:  translator.currentLanguage == 'ar' ? Image.asset(
                  "assets/images/arrow_right.png",
                  height: height * .03,
                ) :Image.asset(
                  "assets/images/arrow_left.png",
                  height: height * .03
                  ,
                ),
              ),


          )),
          SizedBox(width: width*.03,),
          Container(
              child: MyText(text: translator.translate( "Reset Password").toUpperCase(), size:EzhyperFont.primary_font_size, weight: FontWeight.bold,)
          ),
        ],
      ),
    ),
    )
   ;
  }
  Widget stepThree(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(text: translator.translate("Step 3 of 3"), size: height * .028, weight: FontWeight.bold,),
        ],
      ),

    );
  }
  Widget textInterPassword() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .85,
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text:
            translator.translate("Please Enter The New Password") , size:EzhyperFont.primary_font_size,weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
  Widget passwordTextField(){
    return StreamBuilder<String>(
        stream: forgetPassword_bloc.password,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: !_passwordVisible,
            hint: translator.translate("Password *"),
            onchange: forgetPassword_bloc.password_change,
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
  Widget confirmTextField(){
    return StreamBuilder<String>(
        stream: forgetPassword_bloc.confirm_password,
        builder: (context, snapshot) {
          return CustomTextField(
            secure: !_confirmPasswordVisible,
            hint: translator.translate("Confirm Password *"),
            onchange: forgetPassword_bloc.confirm_password_change,
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
  Widget resetButton(){
    return StaggerAnimation(
      titleButton:translator.translate("Reset Password").toUpperCase(),
      buttonController: _loginButtonController.view,
      onTap: () {
        if (!isLoading) {
          forgetPassword_bloc.add(changePasswordClick());

        }
      },
    );


  }



}
